Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D38517A5BA
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Mar 2020 13:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgCEMyG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Mar 2020 07:54:06 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50363 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgCEMyE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Mar 2020 07:54:04 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so6186376wmb.0
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Mar 2020 04:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=UithumxeWzYgScx9rLpMyD2GJqEdo81auVSNbfn9oiY=;
        b=f6PmxY+OolwFWG6Qlwyz2Vw3Fx3A+kmQsoP2kyPGcXtEWvliRhBV5iONwsB4PRtoHu
         HvtCtJiLV+XvTInlE90TtwWIowBizogvXcRXTobxU9eLqYTvBiNAsfyp4qIXeCRp7xR0
         LGoYy8e9/mmZW1JFe/3FVRueKfq8NbiHwb5Qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=UithumxeWzYgScx9rLpMyD2GJqEdo81auVSNbfn9oiY=;
        b=uY7RTAEdIQgi9y/72pWMXK6hszbDVYnGho1AMHDzX+WwfTpWKbMj7r+lmxkcTBW1Bi
         qMvhMIRa/FSrSMjkH/gMqCfOEVcFLCpipbGdXJIzwG4g2WY86dcVY8zp7U/lYb7+ud6p
         J+75PFl/MIwvEr13kCJW1xtBqBSa4fmeCSIAgro/MP95xp10oKFdI39vVQlXu5J7L9Y1
         HNip+fV0loejMFsV79ByozHQ/EY/d0g8FX06njbtTcJ9t7MqEP5Gt6nFiaWk9LheIlei
         ntsYUfDCkZIrCnSc9/oP94B4VEIqs3p5jJ7YNAFS8q8WeXUb0mQ84Rg0Jlg3Mpt7W9Bl
         VAUw==
X-Gm-Message-State: ANhLgQ0Q9d31fp/b19iAG1799VFk7yi5CC4wZ/yXkeH6Rx9K+uIxulRu
        t2xwfEIdVXBOxDkGAS7WauaXCw==
X-Google-Smtp-Source: ADFU+vtVxwix/QuB6JjhX0awb1vybd4BvpFB+lIY68z69hOr/TCDPZBDyFJM31X5dKcZBJjdP0iwtw==
X-Received: by 2002:a1c:7c08:: with SMTP id x8mr9227427wmc.71.1583412841132;
        Thu, 05 Mar 2020 04:54:01 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id i18sm41145017wrv.30.2020.03.05.04.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 04:54:00 -0800 (PST)
References: <20200304101318.5225-1-lmb@cloudflare.com> <20200304101318.5225-10-lmb@cloudflare.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     john.fastabend@gmail.com, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team@cloudflare.com, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 09/12] selftests: bpf: don't listen() on UDP sockets
In-reply-to: <20200304101318.5225-10-lmb@cloudflare.com>
Date:   Thu, 05 Mar 2020 13:53:59 +0100
Message-ID: <878skfynbs.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 04, 2020 at 11:13 AM CET, Lorenz Bauer wrote:
> Most tests for TCP sockmap can be adapted to UDP sockmap if the
> listen call is skipped. Rename listen_loopback, etc. to socket_loopback
> and skip listen() for SOCK_DGRAM.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---

FWIW, Go has net.ListenUDP so I don't think it would be very confusing
to leave the helper name as is.

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

[...]
