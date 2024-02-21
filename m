Return-Path: <linux-kselftest+bounces-5118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5E585CE1E
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 03:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DFEB1C22832
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 02:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6563E2837B;
	Wed, 21 Feb 2024 02:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmGXgnRR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D345C38FB2;
	Wed, 21 Feb 2024 02:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708483177; cv=none; b=YPEb4xvw9xxJrme5GKqUrjX2Kr2XGKDg2USj3CfzkkwGiJ8XchOGV+bnc1UIUEUMgrIcVAna77Pf3U4kZ7bBMqykl2eDcCXxQiS/rTP+l+qaJoH0XBmwc2FXGsrb0JM8R3pAIS2R771Nli4bDrOIiIC+ttw7XgQT8pe+fcUPW/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708483177; c=relaxed/simple;
	bh=VPbKVByFJjX349MDKQOIWBVjQlbUtiYNqQqrR8+PYLk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=OSfsxOf6zPGEenpz/cQ4HxFzxBhiPYIg1yOR2VayJRBBLwC/EqmVNAc3tZahJWeOfj5Wb1t65Mgjs8oOSwlU9yCr0P0NSsMWpDgVOMbszPTaM77AiqfVUMM0f9mwcdH3v6MJ0Jy677969xEcGScy9ftOCTCSrKTObmRwkQfoOPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmGXgnRR; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-36519980c04so8834455ab.3;
        Tue, 20 Feb 2024 18:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708483175; x=1709087975; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPbKVByFJjX349MDKQOIWBVjQlbUtiYNqQqrR8+PYLk=;
        b=kmGXgnRRXKEi+/FKxaU4bbQEsYsmwHpuK0jlsjXfQAJGDJz8RFkcfA/0lpZtjAhPcT
         IS93gKZ+vRwm3o3QioFS87O8f8H9Fac83/UNtt4bBMeM+pHkngY+9iPchM5yAxuEKRIo
         T+x4Hf5K2oOzj84hc+mUFsups/Ue1PkTktX0qa+r7dk39E2LzIYF4am/fxcc0nvjtTV2
         CyUaM6a06N5wbUBGRhnp+pxjCB/Lfxpyv9bfvA+pDyQQRTii5nH8eseP2RPUVwLsTRjw
         moSzAnj+jOYQ+0KPIBAZadnWgF7gnudSTgh1n2jAeGeL1z+rh0fAQNC/XINdLTMxKuS1
         Ecng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708483175; x=1709087975;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VPbKVByFJjX349MDKQOIWBVjQlbUtiYNqQqrR8+PYLk=;
        b=Jyyky+t1Y6ZyJP3dsjiK5CtsGZO0zE5/fKMLWosWy6NL3urCQUPdRd1FUkDNuMk1X4
         xVaFhRfJV8IOltqoJyBJs56zluzF6RBHXOOS7Rlv99qiWWHmD8Xstx3vMm+kuDLZhPny
         toLIgl9vTNGFZg7RNebb3BmeWs46vVY6OH3XsN1hBHuSsczeTSGIfWdx4+xyIN5wXWkg
         6PtaKKurz0TY5Yfo2u2RZ4NX/rVfTShzyobDTRnjVIne+uwkEbBT7y8ht6yzlmB+98bO
         V4CLxDdRlEvOzMDArJxZ8i1lucNz/pjy+8VpApCrkTDXDVNi654B5SseeEjJOK72srON
         sCjA==
X-Forwarded-Encrypted: i=1; AJvYcCW3YnLoQ6IA9qLBeSklEIR78K6PA+lIH/pXuiN1HNy0OOq9HD9FWBk9CN7Ic702bnQB7EQ8d/vQ0LFDKg2mW6E2jjRgbwK+8xAANZIVOVLqkLTKa+ZTBC6fPMkpBwVfW/R2PELJKINltp5tU7rquaoj9XE2ludEQgAN/eaV+6pHwkS5xMu8AWCER8LfAQ==
X-Gm-Message-State: AOJu0Yw72HyKKV2l0zOYKbypWW8OcDRmWSlwm9SPo2faXK4geJetgL1P
	j7uyntxOCU6HJHuPQYPS/h6EgMJRQbTMJ8ph/smBdAUxNs3Sb5IM
X-Google-Smtp-Source: AGHT+IGuUub5cu04oBsjpRwTFuIrjWyna9xErnVuVXETJA1DYvMTEPcDIDN+QO5gMxTkrhhgIabvrw==
X-Received: by 2002:a05:6e02:1447:b0:365:2247:a04 with SMTP id p7-20020a056e02144700b0036522470a04mr11843477ilo.9.1708483174810;
        Tue, 20 Feb 2024 18:39:34 -0800 (PST)
Received: from smtpclient.apple ([47.254.32.37])
        by smtp.gmail.com with ESMTPSA id b10-20020a056e020c8a00b00364f32170c8sm3186767ile.1.2024.02.20.18.39.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Feb 2024 18:39:34 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH]     Fix implicit cast warning in test_klp_state.c
From: zhang warden <zhangwarden@gmail.com>
In-Reply-To: <6fcd7da4-f7c1-4f2c-9214-70ec77443572@gmail.com>
Date: Wed, 21 Feb 2024 10:38:56 +0800
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>,
 jikos@kernel.org,
 joe.lawrence@redhat.com,
 jpoimboe@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org,
 linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 live-patching@vger.kernel.org,
 mbenes@suse.cz,
 pmladek@suse.com,
 shuah@kernel.org,
 skhan@linuxfoundation.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B052E4A4-3652-452F-B4F9-F36860143CC3@gmail.com>
References: <6fcd7da4-f7c1-4f2c-9214-70ec77443572@gmail.com>
To: Shresth Prasad <shresthprasad7@gmail.com>
X-Mailer: Apple Mail (2.3731.500.231)

Would you please pasting the original warning of your complier?=20
And did you check your source code if your source code is the the latest =
version?

Regards,
Warden

> On Feb 20, 2024, at 21:20, Shresth Prasad <shresthprasad7@gmail.com> =
wrote:
>=20
>> What compiler version and architecture? Are you >compiling using =
flags like W=3D1?
>> I would advise you to always add more information >about how the =
problem
>> manifests, and what you are executing. This can >help to nail down =
the issue quicker.
>=20
> I'll keep that in mind. I'm on an x86_64 system with gcc version =
13.2.1 20230801.
>=20
> I'm using the command `make -j15 -C tools/testing/selftests` with no =
additional flags.
>=20
> Regards,
> Shresth


