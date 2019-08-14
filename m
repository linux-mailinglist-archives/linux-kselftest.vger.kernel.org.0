Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDB068D68D
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2019 16:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbfHNOuN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Aug 2019 10:50:13 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:41564 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfHNOuN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Aug 2019 10:50:13 -0400
Received: by mail-ot1-f50.google.com with SMTP id o101so30022824ota.8
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Aug 2019 07:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SjwXtOLugFGTQbAbDkx25fYS7TOIJuf2NpBgbWhjHfY=;
        b=RLJURIjBnb9x4omahDdgk/LHDowqq4zd9Rr9TTlSkJcNqDSawcf22Ez0pLLDueSkNS
         mn+Ym0AwuW+HzYSOPS1EOm1NoXfKCdcVaq3TRuZ2HFog3dLB2rJun/nXynpDL0SoYqkI
         nBM9ZdMi10gHqbL17qmwXcGNXSUR5O3DWful9wWtij5iW15qRo7Do5Dam3ZBdZR7+hgj
         Fgww5PGqoaojPSSaKW0JGXGepocVobNiJhEVwTlWiiJT34p3wjCuIXZg5annBqS2aUKN
         cq5Vt1G9UKoh2ldgwjEgndn1iwG+ItSPy1K8NCYgQfFnflJ0pQoMtlzlrOjlPIjHQ4bD
         qSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SjwXtOLugFGTQbAbDkx25fYS7TOIJuf2NpBgbWhjHfY=;
        b=bv4FLMVibyiyJdqKJCN4M8woVVmwLEwqczJI/mOiDM5nGehj0jHHMxrdGMUHjD1BWm
         TS/FyKmu2+NETJBSrB4qf8xENkbjPt65EQSD6A+9ij3XKGNQGkd6XPns7ZI7Gxbycnon
         H98xk3FGsmyGMt9LNLjwGYKDqbUisda9UqnMD7A61cevCNygL/WomLo5E+jL5AHhgxc8
         ShKISlOwBxmmJIQ/noHh5R4ur6OiswWeTbqTzzOcT8gQsCUHEQL+FDYGn1P3H9FPUfV+
         lpYLSE56+wvQmhQlwF8xbJIuuMEEl4ezEoOUgrTMqdwBVgk1I87D5yDAiqfv9gFCRXs7
         1V+g==
X-Gm-Message-State: APjAAAVIybW7lvDSmtekCCLWHFTknMi7JSFuZ1qiC2JwWtPql9J5++nH
        ZU6rktr95ptfxoICqQzS/zRdctvdIPU=
X-Google-Smtp-Source: APXvYqx1pLxEDbTP0H4lkTRVbXzk9u9zbN5d0B3oQeOkU+cf8BDPrrU1JzQlwSgsqBpziAM6gNlyQw==
X-Received: by 2002:a5d:8b52:: with SMTP id c18mr279593iot.89.1565794212265;
        Wed, 14 Aug 2019 07:50:12 -0700 (PDT)
Received: from ?IPv6:2601:282:800:fd80:2df7:1ba3:122d:3bc? ([2601:282:800:fd80:2df7:1ba3:122d:3bc])
        by smtp.googlemail.com with ESMTPSA id v13sm89128iol.60.2019.08.14.07.50.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 07:50:11 -0700 (PDT)
Subject: Re: [bug report] selftests: Add nettest
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-kselftest@vger.kernel.org
References: <20190814141224.GA32264@mwanda>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <7d43385d-3ac1-b4b1-2e6d-121b9c424c3a@gmail.com>
Date:   Wed, 14 Aug 2019 08:50:10 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190814141224.GA32264@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/14/19 8:12 AM, Dan Carpenter wrote:
> "tmp" is unsigned so it can't be negative.  Also all the callers assume
> that get_ifidx() returns negatives on error but it looks like it really
> returns zero on error so it's a bit unclear to me.

thanks for the report; will send a fix.
