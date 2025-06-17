Return-Path: <linux-kselftest+bounces-35197-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E4FADC75F
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 12:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD2103AECE5
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 10:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5222C324E;
	Tue, 17 Jun 2025 10:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ztsa+UgO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AFA288CB5
	for <linux-kselftest@vger.kernel.org>; Tue, 17 Jun 2025 10:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750154459; cv=none; b=NqU535Gws16dvYvZzYhc92UpIKyUkW/e0BIsm60x0Y+dhQN00ubNqxE6DlCSQ72PCHX+Bsdr2p99dTZy4wrxikISnmxzWCCTfuKl8Ec/wUOlwD4a5ydar0sh8gE7bmGqnzUL+QL2gtgNyyCmqQJr+TiVgaw8sHZpJ19M4lWKork=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750154459; c=relaxed/simple;
	bh=63f0TqEe7ZSJlAEEDh5c6QP7qrLi0rXRzYggtZFz3+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mk4OHHBjvBrS5K5L3277zBB1tsgVofBRV/KDZx4lHWZT2dGhomTULNKOdUKN6tSLOkqIF4H8TVetq37dCJyTDW24d8wGicpMvS1i3RAeOyh7io5umlt6monNhAVzMJrENWOnWeAeCRdQTfGpIBuHuifC1sZx+Dv0k7gNpJ+GRKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ztsa+UgO; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-450ce671a08so34207625e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jun 2025 03:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750154456; x=1750759256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=63f0TqEe7ZSJlAEEDh5c6QP7qrLi0rXRzYggtZFz3+4=;
        b=Ztsa+UgOfW/vmywPz5ORYuybLP0dYfXEx7KKoNl7AVRruM1QSq905zjzfSR9miSJ/D
         hmyq2qaA+lb1x0YFbEpFqrz8W4N9p7aPxPxhabgyiap2OMQEfKHdGsOV4szkVTC+L6BW
         fkSnN5AXMIJKmacD5HeJ8MLkZOxRganype1ZIATf9tx2Lc+21LA5J8d2EUWzipjDp+fR
         ZL4b0BmXvsmDKlK85c95PPvtVzS+15EwzlPJetBS9bDo60lxc7qBxi11Ftxz9pFDfMWP
         fhzASrS8GNiMljS4/mBNtg++creM46pQo595o711WBo9lpNWE5Penb8s0MM2sKToIHHF
         2PUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750154456; x=1750759256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63f0TqEe7ZSJlAEEDh5c6QP7qrLi0rXRzYggtZFz3+4=;
        b=YEjuGD/OtNoR/OCiAeHYlAPyC8ThUymoJj4lVKTOwoIEjO8IBBGKpG2IJA6E+9vKPz
         QYvhgtuwnumkKsrOjpejPPzr1DHDgHOKeinUjCkOpiFWeVe85V2wJuy1Y2CqPOPig9FD
         PHESsc8JPSWaUZkhF5JcP88egS2+gW6Kk1ZTgHvg6xlM5oy3eugWW1tWsy75Wb2fOgVp
         LTUV54xdaAr9k/YEFtb7sBLBf8xmbXRrwViFJorSXn1R1QwF6Ysb93vJ54Tb2b99/Xs9
         /FLl68otYuvluNDIcTcZcrqSSq4z0kZcXz3I3tzS681oJqWvAGPFBSGSfUFMBuJfSJue
         /iMA==
X-Forwarded-Encrypted: i=1; AJvYcCVjLxO5FSpOFzW+0VLr/FyyqC/R+Nz434tPhgyAzl5n7D4WXxsVp2zWrH5Tt7YAxIfJDfFDggXaLTv0SpNQuOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Z+g4EgZCgJ+hqB2hOX02VsHpYaak7ZBEfVUH/E1qMl7D2q9I
	9Z/GTmBM2FTZ7mrTRnRXM9z79NombEyVohiX7WVHWFTnHSHQrDfu1MQSSynuXmqoU6U=
X-Gm-Gg: ASbGncsNlTzoG7cx3x0smxAC35xcuANBobClzlug2SA+OLbqIBLtqDn5jYumifcjwwm
	cr4r12H0LoBF5++wGpmJX2Hh5xm/aKOifCvoW0zjR+Ik/DHJEUL+US+xWNWSGl7C5kNLkaAnT3n
	BjhDe+66ZB7vJqqkEzXavkkzJGgfePCax76ZrPag1nkoAvdFIQHnFcQ4iZiL4jfkxAxm/OAEyZX
	SuP/y3v8Mt02FXIbT1ykpVpFYdOPmZVC1S1tjVrR/aitE46/x+1VamDQthFw+EmvR3SSB1l+LQb
	09xKdyO5z78Uv2kmZ6g8/SavQR+/dIEmbvECoXoadNSjOOx2mz9i78o7cLiRBxS0
X-Google-Smtp-Source: AGHT+IFOY4uMo1XQEX4RuwIHAMfgibmwRB22iBO5mpSJQ1+dfkCUk/eEmOPDTUbzxCn/VYVxqmedIA==
X-Received: by 2002:a05:600d:10f:b0:452:fdfa:3b3b with SMTP id 5b1f17b1804b1-4533cadf885mr65921715e9.5.1750154454019;
        Tue, 17 Jun 2025 03:00:54 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e195768sm171790845e9.0.2025.06.17.03.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 03:00:53 -0700 (PDT)
Date: Tue, 17 Jun 2025 12:00:51 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: syzbot <syzbot+31eb4d4e7d9bc1fc1312@syzkaller.appspotmail.com>, 
	inwardvessel@gmail.com
Cc: akpm@linux-foundation.org, andrii@kernel.org, ast@kernel.org, 
	axboe@kernel.dk, bpf@vger.kernel.org, cgroups@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, hannes@cmpxchg.org, haoluo@google.com, 
	hawk@kernel.org, john.fastabend@gmail.com, jolsa@kernel.org, josef@toxicpanda.com, 
	kpsingh@kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, martin.lau@linux.dev, mhocko@kernel.org, 
	muchun.song@linux.dev, mykolal@fb.com, netdev@vger.kernel.org, roman.gushchin@linux.dev, 
	sdf@fomichev.me, shakeel.butt@linux.dev, shuah@kernel.org, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org, yonghong.song@linux.dev
Subject: Re: [syzbot] [cgroups?] general protection fault in
 __cgroup_rstat_lock
Message-ID: <qzzfped7jds7kcr466zahbrcw2eg5n6ke7drzxm6btexv36ca2@mici3xiuajuz>
References: <6751e769.050a0220.b4160.01df.GAE@google.com>
 <683c7dee.a00a0220.d8eae.0032.GAE@google.com>
 <p32ytuin2hmxacacroykhtfxf6l5l7sji33dt4xknnojqm4xh2@hrldb5d6fgfj>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="krlwbo2bq63d5qwa"
Content-Disposition: inline
In-Reply-To: <p32ytuin2hmxacacroykhtfxf6l5l7sji33dt4xknnojqm4xh2@hrldb5d6fgfj>


--krlwbo2bq63d5qwa
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [syzbot] [cgroups?] general protection fault in
 __cgroup_rstat_lock
MIME-Version: 1.0

On Mon, Jun 02, 2025 at 04:15:56PM +0200, Michal Koutn=FD <mkoutny@suse.com=
> wrote:
> I'd say this might be relevant (although I don't see the possibly
> incorrect error handlnig path) but it doesn't mean this commit fixes it,
> it'd rather require the reproducer to adjust the N on this path.

Hm, possibly syzbot caught up here [1]:

-mkdir(&(0x7f0000000000)=3D'./cgroup/file0\x00', 0xd0939199c36b4d28) (fail_=
nth: 8)
+mkdirat$cgroup_root(0xffffffffffffff9c, &(0x7f00000005c0)=3D'./cgroup.net/=
syz0\x00', 0x1ff) (fail_nth: 23)

So there's something fishy in the error handling.

HTH,
Michal

[1] https://lore.kernel.org/lkml/68403875.a00a0220.d4325.000a.GAE@google.co=
m/

--krlwbo2bq63d5qwa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaFE80QAKCRB+PQLnlNv4
CFc5AQDFUQDIxN7rZwIY/4HwJm40c4uz7Kwbk8e3RX9sQwVOOQEA0j9JsDa/0bOB
mCi/pTl0V4lRqubAZXTV4nhvtAtknwY=
=+ozi
-----END PGP SIGNATURE-----

--krlwbo2bq63d5qwa--

