Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4261011F57A
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Dec 2019 04:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfLOD5N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 14 Dec 2019 22:57:13 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38542 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfLOD5N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 14 Dec 2019 22:57:13 -0500
Received: by mail-pg1-f193.google.com with SMTP id a33so1669012pgm.5
        for <linux-kselftest@vger.kernel.org>; Sat, 14 Dec 2019 19:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=mD0Q7oQYjKwsMg2M4wabWtadHwqClbEf7Ae0x/K5NMQ=;
        b=y8KYw7nx/0imlHvkK8hcfnQhZoBnj7jpKV5qC1x6NGQC8eB6n7vZakzNmuQ1Le2rT8
         agP7oca0AxBdWDhYoxNvY2OReccDjAirKrxfSQe1ea23vsV+UQPVtVWpipKNC/dRAHRi
         CkJNBil5RyOEiEHC+hCZxmFIPWvmqoUxgPPEGH7DvA2sW9+jN5yIafikJvTjBwQ19zoy
         8gHmrVTo9uFx2nuIBH+IA2pFGIxOKK/czJux9fkqNLWH/p11Fo4wMGjAnN2Oyi9Nx6pS
         dy1WWvUZVAMkG2vqw1mDgzzhTveYPjVy2PeYEe4GV3BxfbiPQNtCU0jE3dciKcuq1NYK
         reFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=mD0Q7oQYjKwsMg2M4wabWtadHwqClbEf7Ae0x/K5NMQ=;
        b=fZ5SQaTUORIipAhstZcFpzb3zHDLa1la+j2FaGF9LALxVrml1cv/dE2EQrdXE5vcIk
         EwT7TyPLV1O870db4PTqcoTirZSTgs0HpBnCy1UeSvWW0qK6xOtusEE+GME9ALtxa5nk
         uIT+dPjIllgNUfKQnQFWuImeOPUPKCG7Ok4UJllb70UYfTNJ+pzM0jV+g342zfs4xpxJ
         eopSYjF7aP8RWtKsDVegWq5OGYyFj1ubJeN+Ee7K1SIXANLG4d4xxQv/uuWg7TEhPrmn
         d5Eu9pwhYJc7De0KIGEQweOfaL4eRe2yXawgxJHy8qCzxdiLlaSMyurWS9eM1z6xo2LX
         WSbg==
X-Gm-Message-State: APjAAAWCJHh4/nCfKwo59MtTXSIIqa4I/CCYmNi4nBBhwZsglUVh7rh0
        0m0raDRb/vC+LOfj783tE9LxUw==
X-Google-Smtp-Source: APXvYqz6bI5msW42zqMqJa8ChbziLHm3II8lGoaSQd+3pIZ6B3/oPn44cKmVhrQtb357WidS/Q2wLQ==
X-Received: by 2002:a63:fc01:: with SMTP id j1mr10175899pgi.220.1576382232363;
        Sat, 14 Dec 2019 19:57:12 -0800 (PST)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id y144sm17828042pfb.188.2019.12.14.19.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2019 19:57:12 -0800 (PST)
Date:   Sat, 14 Dec 2019 19:57:08 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Shuah Khan <shuah@kernel.org>,
        Simon Horman <simon.horman@netronome.com>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Paolo Pisati <paolo.pisati@canonical.com>
Subject: Re: [PATCH] selftests: net: tls: remove recv_rcvbuf test
Message-ID: <20191214195708.0f69a0a9@cakuba.netronome.com>
In-Reply-To: <20191213103903.29777-1-cascardo@canonical.com>
References: <20191213103903.29777-1-cascardo@canonical.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 13 Dec 2019 07:39:02 -0300, Thadeu Lima de Souza Cascardo wrote:
> This test only works when [1] is applied, which was rejected.
> 
> Basically, the errors are reported and cleared. In this particular case of
> tls sockets, following reads will block.
> 
> The test case was originally submitted with the rejected patch, but, then,
> was included as part of a different patchset, possibly by mistake.
> 
> [1] https://lore.kernel.org/netdev/20191007035323.4360-2-jakub.kicinski@netronome.com/#t
> 
> Thanks Paolo Pisati for pointing out the original patchset where this
> appeared.
> 
> Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
> Fixes: 65190f77424d (selftests/tls: add a test for fragmented messages)
> Reported-by: Paolo Pisati <paolo.pisati@canonical.com>
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>

Applied to net and queued for stable, thank you!
