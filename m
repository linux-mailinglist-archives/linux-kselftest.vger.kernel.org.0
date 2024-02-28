Return-Path: <linux-kselftest+bounces-5551-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FF886B87A
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 20:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96CD51F21BCA
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 19:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E6B5E06A;
	Wed, 28 Feb 2024 19:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="If6AmXJK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2EE5E063;
	Wed, 28 Feb 2024 19:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709149504; cv=none; b=FKSCbPEriwEQRe0Q7BEgv0/jA0Yh3Mx1s4+tL6ABmHCbKH/RDmWJNfXxY/uxMlr2K842cztShW7f2gpIq+Fjer9xoC0FIQv4ZjfxLzFjBgMBQ3i3YIsnA49E/SlNdItiepZbZYImJTVGRnSkRPWYTNXQhakbL49qqf9Eaqf5igQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709149504; c=relaxed/simple;
	bh=RmY6FThNkxGmlbB0Exm3Wo1qtpWs1/pqZKVhO300w8E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RdEDlxT5tVF/mcLkJZu/UXrmiLAn1qdkDlpsTYYvemwbDr8Aa7x+I+0rzDRYkNIMYhRotKJcf7MylyITyD717T5kEZEcYRJPfCxibUpvIJWf4NsJ8t25S782ybjiNfEopGcLS3NXk9A3mHegnJtNBAilT9G0rQJZbNPnhBip4pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=If6AmXJK; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-365124888a5so816925ab.1;
        Wed, 28 Feb 2024 11:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709149502; x=1709754302; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=9xZ8xmcjSfjLYlMC6SCBTArV0VkBy+6b9iBOrLgBynQ=;
        b=If6AmXJKl60NvbICp8HpdBHSOBRkIvVLGKABmchVRK3gnv+03G/trS6srzuY3A5tQP
         z9c3m3xdbfTxSW9u+3zIB3z3MRSg5ozi5og5HRfvxuSTnEOIOkJwfBcfsKTG01pAEjlm
         5k9KWYuVTfdDkNq/R1wJYWP2Sjnxn3SNpLxQfcRINTq+MDg3vHIb+XEA2mGcSdK4pWoD
         0dHR2QplE2eFMCavV3QOCc6m80d1tKf8BhE1qteUVYXBPDRZCeQd+BO2EkZF66WSttzh
         b//Di4fhugKPLM021YqP7Ox/RTgJQU3+LTLP0rWsLP3ztd0XuxH15dimhxloAaPKSY++
         J5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709149502; x=1709754302;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9xZ8xmcjSfjLYlMC6SCBTArV0VkBy+6b9iBOrLgBynQ=;
        b=RWUex5diRVilpvXt2ZuW/xKJkak9wOw7FklfZJT+4YgnKpmVU/eidlorD2CK1kh5Me
         bBWiAW1hZoLvVRzdq4LpkjEWr2XvYt60DHMGa8p4A5kpMcjW5xKPTNTJJ4aFnHG7L3e7
         PkIWown587cpvR5Ak/HE1GFV8yhLaFuxk9+E1QjItAMiUg/xLsWG1jW+CO/3LNMczjy3
         QxBo9xihcTmw68TmXt5lR+zhFRqWqBz7hlr3FLucUJOQPBnU/pYVqBjSe6emXJ6u/NDT
         mtAWAOdUqn9ZVCLhlYjajVMrfq+vqRq9S7+bqNIKKz0voQqmjRGWiR3tb19OMWeefZPF
         K8jw==
X-Forwarded-Encrypted: i=1; AJvYcCUKptZEp++rV9x4jCIAdhL2cRoWS8m4n0j+sTJX8lHRgBupIeV0jL2qA3MpZoRlrWTwO/1KLn6Kf3ay5vUNNVWAez4SKYZ5rNhN6q2j1xqWI1O1rxASPMeUeXyq/bEuSzUUt1b7kOmqTTG+A3LL
X-Gm-Message-State: AOJu0YxZpzQ1qSUvnBYBKkgkx/krNcXd/E3D+f6hIcuuMLg+pB4tpsz5
	OFEMMGwdCGlSmvWqPC5sK8wkeqG4py+vgudw+Dup7fvdcUVCzrpj6K/jeHO+
X-Google-Smtp-Source: AGHT+IFnSI1+gnNkWI/zc0c8dXyqPZhw+XDdNUnqDGuxILt7h4aCQ7+b2dfGiRBanV+bDvtqtxmvdg==
X-Received: by 2002:a92:d986:0:b0:365:245c:6c99 with SMTP id r6-20020a92d986000000b00365245c6c99mr268427iln.29.1709149502498;
        Wed, 28 Feb 2024 11:45:02 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c5-20020a056e020cc500b00365843633bcsm21471ilj.83.2024.02.28.11.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 11:45:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 28 Feb 2024 11:45:00 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Subject: lock warnings in dev_addr_lists test
Message-ID: <48c4d3db-66d5-4a9a-ab9e-9036db7222dc@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

when running the dev_addr_lists unit test with lock debugging enabled,
I always get the following lockdep warning.

[    7.031327] ====================================
[    7.031393] WARNING: kunit_try_catch/1886 still has locks held!
[    7.031478] 6.8.0-rc6-00053-g0fec7343edb5-dirty #1 Tainted: G        W        N
[    7.031728] ------------------------------------
[    7.031816] 1 lock held by kunit_try_catch/1886:
[    7.031896]  #0: ffffffff8ed35008 (rtnl_mutex){+.+.}-{3:3}, at: dev_addr_test_init+0x6a/0x100

Instrumentation shows that dev_addr_test_exit() is called, but only
after the warning fires.

Is this a problem with kunit tests or a problem with this specific test ?

Thanks,
Guenter

