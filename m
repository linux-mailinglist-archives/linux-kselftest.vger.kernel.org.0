Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709297E7492
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Nov 2023 23:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjKIWx1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Nov 2023 17:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjKIWx0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Nov 2023 17:53:26 -0500
X-Greylist: delayed 902 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Nov 2023 14:53:24 PST
Received: from grey.apple.relay.mailchannels.net (grey.apple.relay.mailchannels.net [23.83.208.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADE24228
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Nov 2023 14:53:23 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 157918406D4
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Nov 2023 22:38:04 +0000 (UTC)
Received: from pdx1-sub0-mail-a219.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id C65348425B2
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Nov 2023 22:38:03 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1699569483; a=rsa-sha256;
        cv=none;
        b=rJAEcgT6rEWj31KtNo3JlOleC4QTsJkssem8NKam9KEk0q1abfuPK7szepks8HgD0Tu8o3
        WJAkGDi/CULeYagF9f1h9QaCZAsRMSEV4IHbPTI3Tdu8bM/pufURi5xr/Y1NRhR1iMyNb3
        IJ1AkxeGru8JjD3laBulI/xWTipvzoBwmTHj40CK99RPiTHiuqUswZBlKgmPsMR3sSTlcO
        yYK6kzDeN1zyudFiHcUcDRsVb4PbIRPo4SnxUgy9VSgs92r0xCE6c2/pZ3BdoDAuIXVPHb
        6I4vK55y51mRjCWyY7PnoNloWYeeiTvjVp4lre1PlN7x48hAgUImOFXs+7t+KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1699569483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=8FdBTqj7EnOPCatPq6Ewwon91Yw3IOaAcb1fC3zTNWc=;
        b=dT43mdYlA08dv8vbA5+yN5SnMZooDaZmCc7Kj/iLTYCTjw7V/3xWjxqnb/2CxN3tbaktJU
        DQEBsWCQ6nXHt326BkoWe1DDfpwHNFSAb58AoYHFbmAcUGxW7ngxLLF2lZrccCMCn8FYMa
        wwuRAnCNIJWlD5Am5aUh9P4pvNFPSQKjJiDhhdlDNwifx1fHcbR9Q1YByhGNh95ctu6K2z
        udQBwoj91oDsoYGaZeTX1gqOku/Gq+JtcK6HYuKk+oMCzsHdKvV4K7dHPtg24Wj/qydDDT
        DukPN/AdX3wp75L+5Iie0NGYrVd22GAXiTVyjefrjx+ZUU8YE+jDAdzNJtgOBg==
ARC-Authentication-Results: i=1;
        rspamd-6f98f74948-x6h89;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Name-Tangy: 06d746574a57c97b_1699569483921_1163868368
X-MC-Loop-Signature: 1699569483921:1674045731
X-MC-Ingress-Time: 1699569483921
Received: from pdx1-sub0-mail-a219.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.101.67.125 (trex/6.9.2);
        Thu, 09 Nov 2023 22:38:03 +0000
Received: from kmjvbox.templeofstupid.com (c-73-231-176-24.hsd1.ca.comcast.net [73.231.176.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a219.dreamhost.com (Postfix) with ESMTPSA id 4SRH0W1Mtlzqn
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Nov 2023 14:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1699569483;
        bh=8FdBTqj7EnOPCatPq6Ewwon91Yw3IOaAcb1fC3zTNWc=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=jzPgAP7uZ6rT3mB5778Ifk3l3q2mOMiYDkuhop9ZKq+5ttWMlmoNDQ8EHme+aRYKD
         CKYw/PGY2R/JRoSsw8BcPWrEHhtq15gAN8ef5lPkynJM33OiiIKyD75hZH9ZLOvYNb
         QM5SIlEFURBw9NOa5W3yRHj9XE3GSfVHdE4vlQrOijeKEF2C1EsxF9AGZclfjr3qZV
         hhdyFKp2HkQwlJ7Y0/lGMGW4p5aQb01Cvv/5SYK4cZcjErbrcyDNHL5p7EE7uC6RLG
         xN1D1Wkaze8YkLJHZeFh193QhX1HHG5Q0viRff8kKl7RVGoDca1WhtK6uUphAR3YOu
         lvM6maUVzg3ng==
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0044
        by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.12);
        Thu, 09 Nov 2023 14:37:28 -0800
Date:   Thu, 9 Nov 2023 14:37:28 -0800
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
Subject: [PATCH 1/2] fuse: ensure submount_lookup is initialized on alloc
Message-ID: <d80c0df75fc601ffd3f957084574f10abaf3bedc.1699564053.git.kjlx@templeofstupid.com>
References: <cover.1699564053.git.kjlx@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1699564053.git.kjlx@templeofstupid.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When introduced, the submount lookup reference tracking neglected to set
an initial value in the fuse inode as part of fuse_inode_alloc.  Users
running with SLUB_DEBUG enabled caught and reported this error.  Fix by
ensuring that this value is always initialized to NULL.

Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
Cc: stable@vger.kernel.org
Fixes: 513dfacefd71 ("fuse: share lookup state between submount and its parent")
---
 fs/fuse/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 243bda3cfdf6..d7ebc322e55b 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -103,6 +103,7 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 	fi->state = 0;
 	mutex_init(&fi->mutex);
 	spin_lock_init(&fi->lock);
+	fi->submount_lookup = NULL;
 	fi->forget = fuse_alloc_forget();
 	if (!fi->forget)
 		goto out_free;
-- 
2.25.1

