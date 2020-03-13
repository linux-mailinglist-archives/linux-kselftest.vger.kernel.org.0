Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9A0184625
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Mar 2020 12:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgCMLpM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Mar 2020 07:45:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39229 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgCMLpL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Mar 2020 07:45:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id r15so11694485wrx.6
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Mar 2020 04:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dgczSmAqVEJOutEhe8hoKbtoOKkA2cKA5aZcMZeUt7M=;
        b=UD5SixymeIdkCPNBEKM6X0ZsncWUrK1nGU65RM9f+VyOlBFoPr91ErZu4D6VfKARM0
         z+hsdamo+rFQVrmdvBKMGL8EuUg8WU6WrRoMmR8DUr2qIGiuJ41UF3gTmnFgy/IVq2g0
         szQS03Dt4ldXw7klloG6Uzco9zcZMQR1GzhMy3WbmaAJea80ZHn6pFXwKQsP5YzV/ST+
         pMqjlB0CB1gg2RsXP3XyqlsUmKYKD/+yriKZzJmIiFGThU3uF1zLh7Kh/gFEnHh+TaDq
         g+2zbTSgHgnh633zpNkrCdkhZFJImsPVmY/vg0uogFE55wiCXMtAq7CQeMbqzDuLEdXP
         3sLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dgczSmAqVEJOutEhe8hoKbtoOKkA2cKA5aZcMZeUt7M=;
        b=aR9KsAkNrvhPbgabqIenNlMNdMPRIGBRm13dWqUGOZ2o7fgir5ZxgFm06MAb3HpMLQ
         PScbzXefWYbZht6nCE7HfuaM29pz9tE74aQM3+b64GCnuQL7PemmKZBcDztqdsQclyzh
         oZIBGfEYO+Y700jdXWFL4lQU9m+c3RWhtApSpE/su3nhXwJDEKDdI5knCGuubsPQpkMF
         gvBW9ZM7nofYumdGjkJgGrWRv/thoQnCSixWLWA6ieHRV+SmXjUWsKrXFB6qPxKTQ7nB
         l2SJyBFyx66RdH+t+CnrB51yq4qxIUtLVL2n6sVyat4GPHRpgUixqwk9YGwau6VJQ6N5
         AcJg==
X-Gm-Message-State: ANhLgQ3wswgBJouzG3inDiL/q+R+PbyUarwLelRjy8WqpnNuDowwd098
        ndSQ+ppqCqFtifbKntIE3p/gOWI9fWc=
X-Google-Smtp-Source: ADFU+vsFcFvVhNYRTCm5ZSliJazxZsWFUHwpM16BAXz4Mnd+bWt88EWTKrmY4oEXFZncdcyAw1dPhg==
X-Received: by 2002:adf:e3cc:: with SMTP id k12mr13352414wrm.266.1584099907848;
        Fri, 13 Mar 2020 04:45:07 -0700 (PDT)
Received: from [192.168.1.10] ([194.35.118.102])
        by smtp.gmail.com with ESMTPSA id d7sm5784478wrc.25.2020.03.13.04.45.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 04:45:07 -0700 (PDT)
Subject: Re: [PATCH bpf-next] tools/bpf: move linux/types.h for selftests and
 bpftool
To:     Tobias Klauser <tklauser@distanz.ch>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20200313113105.6918-1-tklauser@distanz.ch>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <9dd3dc71-90b6-1557-4459-2b99183bf6a7@isovalent.com>
Date:   Fri, 13 Mar 2020 11:45:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200313113105.6918-1-tklauser@distanz.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

2020-03-13 12:31 UTC+0100 ~ Tobias Klauser <tklauser@distanz.ch>
> Commit fe4eb069edb7 ("bpftool: Use linux/types.h from source tree for
> profiler build") added a build dependency on tools/testing/selftests/bpf
> to tools/bpf/bpftool. This is suboptimal with respect to a possible
> stand-alone build of bpftool.
> 
> Fix this by moving
> tools/testing/selftests/bpf/include/uapi/linux/types.h to
> tools/include/uapi/linux/types.h
> 
> This requires an adjustment in the include search path order for the
> tests in tools/testing/selftests/bpf so that tools/include/linux/types.h
> is selected when building host binaries and
> tools/include/uapi/linux/types.h is selected when building bpf binaries.
> 
> Verified by compiling bpftool and the bpf selftests on x86_64 with this
> change.

Compiles on my setup too.

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
