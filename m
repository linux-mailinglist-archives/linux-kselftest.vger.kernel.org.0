Return-Path: <linux-kselftest+bounces-29795-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9106CA70CD3
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 23:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E565189BA27
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 22:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1F3269D16;
	Tue, 25 Mar 2025 22:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bz9dH6x9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE269269D1F
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Mar 2025 22:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742941576; cv=none; b=rENxAzvtuov9EWSGamKlenjreBUp2l03cURomGw7ONGd5wmRueDLHfgSfSR+D6D7gOxraJfWDJm3pPBgGW4hyuZDj05OKT2gHEnhjuR6m1tMkgSF4mqb9DDx9yMoji9UzsxCkoF36mClpUSWFtsmvoD8nc7b2364KOTwh5LmUBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742941576; c=relaxed/simple;
	bh=KKtFXFITA4hOuLwA4HcWHFD1w/QWq7sNwvdwYb0AV3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f15JSZlY/sn9GKVU84Y4r7L5CZESeiXAyjELQaSrrr6NSCmOOphjkherYs6ysrpcjhIF0lrDG+bGm/FvMmBgB9cTB/qTi1y19KRkmVb2ckJO4VPK9aglZWL1req98weQCF6E26ZuhtRjcd2fRg5lB03g+wZLfuHlYRxlypmsUK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bz9dH6x9; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-22423adf751so116779455ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Mar 2025 15:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742941574; x=1743546374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KKtFXFITA4hOuLwA4HcWHFD1w/QWq7sNwvdwYb0AV3c=;
        b=bz9dH6x9Mz+fIEKoQQzJKPqpr4dPafCNM4vlLhiEYAoZ/V8uyM1JQO9SBkKlOkFLtZ
         8Wbyqgo/mgcm9xGnBVBBpAeMPoYlKQR7IKLHQthPHb4vxX6UdDrygIqCVq1Vabv/Fyp4
         CujRq0VEDYcKdcl8it5KKfx5oRfYEQmEbQIP44kzSNzYVBlgg0k9wCpH16TVfAu+IU4/
         SKmsoE9OGhGxcgMNvkZRtP2MPlkHwoeZgJFdfwxjJrwR9VcehdG7BnmuLHwGoW0vJFsq
         8SbVu1lQlgz5eH7LpixyYMW3MBfjvFUmC62YLrr7LA113yQGkrPX9U8N1Uf7/grc9Fsm
         dJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742941574; x=1743546374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKtFXFITA4hOuLwA4HcWHFD1w/QWq7sNwvdwYb0AV3c=;
        b=cCeaVlcbjLK0z0L3EEol6wHXMU0OgrRGy63ReYwu48ULaNP3nFdHEOHQw/XxyaF4dF
         p2IRC8aQfYQxr1B9ogzOTOX4jazLPtmdvGHnHrmtZtsfHe9HWSSDWsTUFQjQKpVgNUff
         CpIediVoJeK8uOC8UudhCVdTTPhi1jwa1ZP1bjsacufOcT6yvhLNFPozrW1iz9FJXDUO
         8V/9gIGivVRBJ+hpk3EvMe1n5ygWORBFDXmedP9ons3qvlKO/OjBOqu2AxBEJ76XD2Oh
         62SG5Lo/DJazL+FEfe7HIPRc9d2pHsVR1fwR8ar6Dd3Rsrm7yVvQBjJBWQaYO3Ly2Aee
         e+eg==
X-Forwarded-Encrypted: i=1; AJvYcCUZGhxUdW+bB8kiJs/Wo5slqeK2NviQ+VoCZn7ApS0P6aMkWHH01fLox45GVSnwr4gRCBNmPS275cTeMyWc1sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHsYDOE8wI7ybtci8zNBBR2GRDCg8C0s1EYBTnRq2eRxTAgHFm
	QDdtj4Jajyavil6nFnqQgXRnyYTCXEGJrSV7h/zIudPxMNyES2JONq0yAFv7KeV/Mkplm/i95jm
	FfIM+kFCmIBY8j4XW+Tt/m5IznvpUb4YN6nIBktisDQEhfQrR
X-Gm-Gg: ASbGncs3eQLOUaYvDhcpfjD9LIW2XdihamZyM75syjw4jY2jqXuHxiz4/1ZPrj26Cuo
	lToU9HyqnMi+IhGVnEl/QHGAPDXxlA33IkqiZ6lB8FVUbNiIWQaQTaFwzEzQtjX6vdCc24k9qhX
	b7zBLvGQ32vpTFm7bUremuDcHzMgmP/VAGLC2vdi4e0Jh9eDjQsdkYTl4pL7cP0vUyS2SdFtq0Z
	A8BEEru3hRaNMeoHzbtQO77+v6BlTT/nyXpnfwrwJvllKgcbaS6DBd6y9XXD2ZeiDc9+uQqb+ia
	XoJXWyBFUEix7qmpXoL8uy26mvtSJ6gzmWQ=
X-Google-Smtp-Source: AGHT+IGT0KKJcSpjdtMSKMKsUWymjpS7sayjzqsLE4bPkiJaL54O/zO+3IKG+hoGFZrocDh08pKlkUao+W+O
X-Received: by 2002:a17:902:f683:b0:21f:136a:a374 with SMTP id d9443c01a7336-22780e25b3dmr295953605ad.43.1742941574203;
        Tue, 25 Mar 2025 15:26:14 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-227eb1938c4sm643615ad.58.2025.03.25.15.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 15:26:14 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 70C3234041F;
	Tue, 25 Mar 2025 16:26:13 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 0EFD8E40158; Tue, 25 Mar 2025 16:26:13 -0600 (MDT)
Date: Tue, 25 Mar 2025 16:26:13 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] selftests: ublk: kublk: use ioctl-encoded opcodes
Message-ID: <Z+MthdcV2jaSBnwC@dev-ushankar.dev.purestorage.com>
References: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
 <20250325-ublk_timeout-v1-1-262f0121a7bd@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325-ublk_timeout-v1-1-262f0121a7bd@purestorage.com>

On Tue, Mar 25, 2025 at 04:19:31PM -0600, Uday Shankar wrote:
> There are a couple of places in the kublk selftests ublk server which
> use the legacy ublk opcodes. These operations fail (with -EOPNOTSUPP) on
> a kernel compiled without CONFIG_BLKDEV_UBLK_LEGACY_OPCODES set. We
> could easily require it to be set as a prerequisite for these selftests,
> but since new applications should not be using the legacy opcodes, use
> the ioctl-encoded opcodes everywhere in kublk.

Is it required to allow for the building of old userspace code (using
legacy opcodes) against new kernel headers? Or do we only need to
guarantee that old userspace code using legacy opcodes that is already
compiled continues to work against newer ublk_drv? If it's the latter
case, maybe we can consider removing the legacy opcode definitions from
the userspace header as a follow-on change?


