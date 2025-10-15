Return-Path: <linux-kselftest+bounces-43153-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 979BABDBFAE
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 03:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141103B45F1
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 01:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AB22F8BF1;
	Wed, 15 Oct 2025 01:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejdovxqZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F042C2372
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 01:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760491572; cv=none; b=bXi+SJDZRy5j3vALb0AS7Fi0haxzFwpdXDPrFZ89EqNuJm7WAJzCtjBLRaHxDPc3HKv4/32CiNgfHKw4gP6bCgPNS1bm8WGQEqI9byyR7D4WNhHfBSxTMWrbdYRzuw96jthW+VCwQvqUlC33UN1wlsfN9oqTDsITbtFag1kxhU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760491572; c=relaxed/simple;
	bh=cjJS0G2aPBCIRiv5AjzjQblvTPPjsjWQvR5I9m1fB1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfGq24qZw6iS9Us2PFHJOaohHQLpcts02pTRLjbsvkkmjmu2VbuqkP5ay45uaWU9/I/kIQ5mNau9Dnj3wBzqwGt3GnuJZmKUHXV7JS2Sgb6e4cCU6BSrWSigaZuav6/+tuEHdc9GXYvtlOyxicUbtHIRp2fovmO+svFBsmgXFzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejdovxqZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2907948c1d2so20705415ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 18:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760491569; x=1761096369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Q5dz5Gj88sNElZ8LH0dTxbQkaOtoFBCo1ZKVE/LXNA=;
        b=ejdovxqZ+y/p8YixvvyohbB/70oK1JnYqCSPfu7ecR/z0XuOuyEXWwYVnXfFxTOmP0
         FzxNYr+oZRaRtuSc5xg3vUGxsCkVRvQMSslFO7yGUsu+JBF5jG58hiLBOeGL4lmp3UF7
         kPW7+BeBJvv05tGThwIUYMyFxKEwzxZvnapuAnAa6dxIg4giX7cKWpSqWJsZIUz/yh0s
         JRo2fcz3OZuj2ue5seXULtJt1MEQfsW3t8HtuCa6Q93bvRwzdKt9L8dVocEMwLc2Dsed
         W72SBvLx2DPdonl1kLxcV4sJ1mHf+rs0cBte0rnmx6Zalq8OzX8naXh4a439i3TlUZ8v
         YmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760491569; x=1761096369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Q5dz5Gj88sNElZ8LH0dTxbQkaOtoFBCo1ZKVE/LXNA=;
        b=EtXgZka3d816RNmZJuT/VgJCo2ifM5pavfVd/Io/ILEGaqX7+ovJo/+UdLTbhVIwpU
         d5XoL/4IrxObAWLJGrVzNCivbxoS7IFGp7GVI5ullmvoCB+fXR7eYCrrBm2W+fH6QDlp
         zg6TuRMbIUmve/zkl5Fj/qoU4yfJ/mXTaRSZJ+OESf+krSEIlVdw9+9m3KG6CvtRDDkJ
         TOVvbBtypkEIGlxcR1ZPZ1MIy2OmyPm8VhOZWTe5tdy625BLj4aC+S57b1LwTUOI/wDZ
         vSw/l3qfDZQyIUB9o8uchWU+0O97HsGDBKSQIN0CeoYDMV97rVkUzYHOnJfs/UKnu6hk
         bolQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1yjAItAktojeFFAv4X86aAjIv37gsHvL6TDQBkUzC8VDJBcYlsoNQaMmeJVLN9/ZjmRYqx8V+dO0SeQQhzDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Kb37qdi2FeFc7fAyMY7wA1WoGO5woh3y+AIkGP8Gqmug0uce
	I01HpLeNjitZEVPfsuzD1FpzCD+S37vZknlb5OsC4Rz9kG9UDC+wlu0S
X-Gm-Gg: ASbGnctNXSIkIE6yHjgj3pLL3dkTdWjWPTaMHLJDRKegRGTUtFQzJJ43tbeQN+W1bC1
	jcadrfRhDJJj3geVLKwdCROoyG8h2C4RF8eYv/YDqxy8U9MshPdPoYwfxMrFekYNz04DH0Ms36F
	1jJwW9sSI0nmlPAO6Jzg9j6zYpV5uQj7TOQP8um4TQY6pdNiWwCsa6Qt/35rvQQ5NxnZZ1KSOJl
	OoD8qAEJvfezVVeBynHZN3rS0FKSuRxNyLvWhXMt/6vSUFq3mRfV6WKT5/WdYN0TKuZvr4L/d4P
	e00BqAaGUnmZCG6kCE7MBHgQ4HRlfZQ0Vs+Q2BzGtVvTyu8S0GSNmb/t5u3Zu/0SI0No+K021uw
	z7NlqPfq4aVdWmZnzlQ5XA/Pes+tI42MZCf8+v5dv8JCZVU9h6D22ZVJ5XFoXaS6BLywBf+y+dz
	PDjR5d/nL58g==
X-Google-Smtp-Source: AGHT+IGzF5+LW53UkepzFQKI1Jzn1qFhxcSosnAtHxXYK8XVZjCibUQ1WkRpULc0fl9NPUgHG3Sndg==
X-Received: by 2002:a17:903:246:b0:27b:defc:802d with SMTP id d9443c01a7336-290272b537bmr343555765ad.28.1760491568988;
        Tue, 14 Oct 2025 18:26:08 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e4930esm176198915ad.54.2025.10.14.18.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 18:26:08 -0700 (PDT)
Date: Wed, 15 Oct 2025 01:25:59 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sdubroca@redhat.com>,
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv4 net-next 1/4] net: add a common function to compute
 features from lowers devices
Message-ID: <aO74J20k16L7jS15@fedora>
References: <20251014080217.47988-1-liuhangbin@gmail.com>
 <20251014080217.47988-2-liuhangbin@gmail.com>
 <sfjjkeub7fmvsktzrx6mmv6zvilno3un665tbqe2punw4azefo@jwuhk23763gc>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sfjjkeub7fmvsktzrx6mmv6zvilno3un665tbqe2punw4azefo@jwuhk23763gc>

Hi Jiri,
On Tue, Oct 14, 2025 at 11:40:12AM +0200, Jiri Pirko wrote:
> >+#define VIRTUAL_DEV_VLAN_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
> 
> I don't like the "virtual" naming. In the past, we always tried to avoid
> that for lower-upper devices like bond/team/bridge/others. Soft-device
> was the used term. Please let the "virtual" term for vitrualization,
> would that be possible?

Sure
> 
> How about "master_upper"? This is already widely used to refer to
> bond/team/bridge/other master soft devices.
> 
> MASTER_UPPER_DEV_VLAN_FEATURES?

I'm not sure if we should avoid using "master" now. Maybe just UPPER_DEV_VLAN_FEATURES?

> [..]
> 
> 
> >+void netdev_compute_features_from_lowers(struct net_device *dev, bool update_header)
> 
> netdev_compute_master_upper_features?

netdev_compute_upper_features?

Thanks
Hangbin

