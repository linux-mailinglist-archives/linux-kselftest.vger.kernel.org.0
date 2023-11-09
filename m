Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858DB7E7469
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Nov 2023 23:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjKIWhg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Nov 2023 17:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjKIWhf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Nov 2023 17:37:35 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A393C01
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Nov 2023 14:37:33 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 9B5C881138
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Nov 2023 22:37:32 +0000 (UTC)
Received: from pdx1-sub0-mail-a219.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 54CED8110B
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Nov 2023 22:37:32 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1699569452; a=rsa-sha256;
        cv=none;
        b=U2RcfznFVgIvhl6kZTKXZ9DN1XgvhUHNM6QbeN0xjfFwITLHYzns+6uRsv8Xef2UGZYQyt
        07YTQ6K5dT8yYpH2H4jLYps5A+trZkabkSvP+QHto4L/kxXrPkTdULQ2cNS2cIQhE4r3Nn
        Pz1pTG/F/mVKANY3ZxG98WHgS/X0TK6x9w6q9aeGUeXdEeFwy0nx3ScGBMfLhSjZrIBKIV
        Vq8ICvezJnSNOpOJ/X6mVzxB7vGJ4o674N2ClAtct6Krqz7LCevOF3SLnvxSmcgAh6jLRw
        gB22n3LWw+bRotWrh2VlXlkoPm8zwCfs7xsGeai9hW65FSaT9fhHl11JOPAvAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1699569452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         dkim-signature; bh=8YwB9PBpFMCaeiI6zpE8rWC2hSXeSpyA9B0exPLdmbY=;
        b=Ok41G6Fuv7ouQgtTNrwYuXSxVK6FGrjLZKCB/BL2rq6dJAZOMfn9GN3WQzp6/S7oB3jvh0
        JvYttw8ww4mIkvbh8QRCXP1HFx27IpNhH/QQ69LCpFtPS0kaKjyXPjTarJ8CKqgInkWhem
        Teq04kfz0MfPlkbOoPBCMUsFP45O3FtaqFsEOHn3EA9ELRnDFw90RP5W3P550kmc2wc2g2
        /+BEjm+GI10l0ikzyZ5FI8XgJlPBFPT0gKP+X3RZA5Cu5Prh5oJYofnOsoPrna9H6oxcDn
        XbmfCf296iqs7/5PTfR+X+y13WvFeLWnKhfVUXKEezdCo14JKvm19fDZ9/6CbA==
ARC-Authentication-Results: i=1;
        rspamd-6f98f74948-h8z6f;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Desert-Bitter: 279e1ad44747d895_1699569452461_2622677825
X-MC-Loop-Signature: 1699569452461:1796348722
X-MC-Ingress-Time: 1699569452461
Received: from pdx1-sub0-mail-a219.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.127.137.45 (trex/6.9.2);
        Thu, 09 Nov 2023 22:37:32 +0000
Received: from kmjvbox.templeofstupid.com (c-73-231-176-24.hsd1.ca.comcast.net [73.231.176.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a219.dreamhost.com (Postfix) with ESMTPSA id 4SRGzv39FRz11y
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Nov 2023 14:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1699569451;
        bh=8YwB9PBpFMCaeiI6zpE8rWC2hSXeSpyA9B0exPLdmbY=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=iXdBe3QqD7hYZNkR3gTX16NMfS0osjVYrWrrlW8DpMru9YBAnHLloxIKsO8SV603N
         MOIz6lOQprbztIl3bFRxvSl9ypsW7G7Gkr8dA2R94UNg+zcTr+bLNDcdJoYITKVL/w
         tq9BS9p/FqpsbsjtTbs/7b8aSRyNK1W977KkkOuaTUSaB1Qe2hvqbMjUv63N+yqhgT
         sgZwk0cVlbCuwyMF2NS9FTBmi/UeYF4/SLgdCgvd1L58tdp0DrTGGny+No6gJ0uaFD
         0xELaaZPVi72foXlwG+c4GacYIbH93Maub+Lg5+xXyy1Sbd1qOnHRwA25f79d18+bW
         Sn91mwHOfiGYQ==
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0044
        by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.12);
        Thu, 09 Nov 2023 14:36:57 -0800
Date:   Thu, 9 Nov 2023 14:36:57 -0800
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Cc:     Miklos Szeredi <mszeredi@redhat.com>, linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>,
        Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>,
        Bernd Schubert <bernd.schubert@fastmail.fm>,
        "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        "Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>,
        "Saarinen, Jani" <jani.saarinen@intel.com>,
        lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        regressions@lists.linux.dev, intel-gfx@lists.freedesktop.org
Subject: [PATCH 0/2] Fuse submount_lookup needs to be initialized
Message-ID: <cover.1699564053.git.kjlx@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Miklos,
I got a couple of bug reports[1][2] this morning from teams that are
tracking regresssions in linux-next.  My patch 513dfacefd71 ("fuse:
share lookup state between submount and its parent") is causing panics
in the fuse unmount path.  The reports came from users with SLUB_DEBUG
enabled, and the additional debug sanitization catches the fact that the
submount_lookup field isn't getting initialized which could lead to a
subsequently bogus attempt to access the submount_lookup structure and
adjust its refcount.

I've added SLUB_DEBUG to my testing kconfig, and have reproduced the
problem using the memfd self-test that was triggering the problem for
both reporters.  With the fix that follows this e-mail, I see no more
erroneous accesses of poisoned slub memory.

I'm a bit unsure of the desired approach for fixing these kinds of
problems.  I'm also away from the office on Nov 10th and Nov 13th, but
expect to be back on the console on the Nov 14th.  Given the gap, I've
prepared a pair of patches, but we only need one.

The first is simply a followup fix that addresses the problem in a
subsequent one-line commit.

If you'd rather revert the entire bad patch and go again, the second
patch in the series is a v5 of the original with the submount_lookup
initialization added.

Either should do, but I wasn't sure which approach was preferable.

Thanks, and my apologies for the inconvenience.

-K

[1] https://lore.kernel.org/linux-fsdevel/CA+G9fYue-dV7t-NrOhWwGshvyboXjb2B6HpCDVDe3bgG7fbnsg@mail.gmail.com/T/#u
[2] https://lore.kernel.org/intel-gfx/SJ1PR11MB6129508509896AD7D0E03114B9AFA@SJ1PR11MB6129.namprd11.prod.outlook.com/T/#u
