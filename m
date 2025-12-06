Return-Path: <linux-kselftest+bounces-47223-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C96DCAA837
	for <lists+linux-kselftest@lfdr.de>; Sat, 06 Dec 2025 15:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 591A0304EB5D
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Dec 2025 14:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF272FE574;
	Sat,  6 Dec 2025 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhH1t8a+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779D3229B36
	for <linux-kselftest@vger.kernel.org>; Sat,  6 Dec 2025 14:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765030019; cv=none; b=Tep7XKBseRshl5kdFTj9sg9iXerhJW9c/FyDVuGYMPSSRK/Cihb2teEd/YvsiL6qWQTfz/OdtlSnUex78Tb5v5r1Z6p3dyx5qXzqqFcrkqDdrkQMz0PCJuRkXkv+ynfm2i6fuSPLu9hewNEQsMjpwqnGdtHvKa32XGNwoUM9pSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765030019; c=relaxed/simple;
	bh=vrfLk2ayZuf6l8AqfvNQb2nC/M/gETf+X2/3kIvvnp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NRXCDtSjVxwOF19n4tFUl3WOsBWJIcreOf9xTU5muntS9+Nw8h31KcBmBf1MGfJ8m1V280yb2xpQP1wi106FKIvsrJVVP06EvED7xVj5G5iOF88pAt5/JRh8RTB/17UShZKsZV8UARQUSqHdqjkLLZApoCQ1RtZHl8xSZwHEiH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhH1t8a+; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-786635a8ce4so24606117b3.2
        for <linux-kselftest@vger.kernel.org>; Sat, 06 Dec 2025 06:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765030017; x=1765634817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrfLk2ayZuf6l8AqfvNQb2nC/M/gETf+X2/3kIvvnp0=;
        b=ZhH1t8a+DxqcJZzRWPdwIrEFa4OissoLMMeovRnYJ58RyrLlC9Lbve4Rt/ZS7Rn9LI
         9u1N6AUmAjrczf9UfFvDAbMsNIzkE4OxzNI8J18/7pI+Ujik85VPk+3tWZvUkDjC9Ike
         q2p3Y7hYGuJ79WFR5ZZ1oUx/d1i+mf68aVyWqehpNcJe5Q7SdlH5emkYYLfJNZTxiTOA
         RfKCP6xbHZAivaP3KB14PM2xZ+dgYqiK26FoinCFsLt0ej/LYS/hjLCviWkI6R2ovyIN
         LIL1+hoqNucoYTKg84CPWtu/CXeF4byErQKNUpq8ixvbE+7+/E/J/0yDHwx/UnfBjHfu
         i43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765030017; x=1765634817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vrfLk2ayZuf6l8AqfvNQb2nC/M/gETf+X2/3kIvvnp0=;
        b=XECia5tql0kKCJSesIugEjX5TktBawsaA+CoBprwUD3Y9iHNSEx+GwWLlmnv+W8JHx
         3i07wN/TzEMSrdhx84Fw8xhRuZg18EKy5xB89yoVsIxUxi2RIBOYW+5BHMy9sbqQhdwr
         FtgSHe3MT2k6kL8kZ1l3RTlg5Udf66MEFSJYoPOuNwYAr6ZRFLdv2Phmb1RDiioICM7o
         QpEH6Y+9qJ2Noy4vdCauo4nDKDTwWt1G1Wv18MV0C7yxBn7ssXBm/eQTdglzCJlxGIUT
         wKmA68gdHYil6VTbF1KfpUtTNGiLA7ymSydsM/heX0ZFw32A+sEwPvL7ofPTrGnpB2n4
         10gQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLD3+t4UKTkO+tM74b1KHF+KtrYKk+GhLozHSM48Pgq2mPUeNNWr019nMFCcu42ICkm1lzRTG2RBBUXAK7kkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/U8fW5XwfoXo+I1+xvg7lmxLTKuFoDt2YvL1KEkrgqdpXSX3v
	Rx2G4i9/o2/TEoLsilAnSPXLaPujgKgkCHVDi3nS68/3sop3wUzDQG7I
X-Gm-Gg: ASbGnct45mCfmaWOuy2As1j7gyqa8duOnCvpCuC7G6hACgdrcEqk0kN68dYKIb+yhhj
	GtHLrngkPfEdAuFm1GTjX9RQPIOTsHf1PsKTuTYnRYUdbUCNNq29kEfJgxSKcfo8fm1cN2X5U4g
	OTfWqmjFiuyb76XqF+joGXVkbpK3d00keq/eKxOafl+xxZN1rFMON+gI9EsvhO4sYYQFCXjfCKY
	9gjcQKOZh28TisyBb5pXPhCAMQpqxg/apujC77/c/T9KUVIO8cir7QOHaRjoaBO3Yi8OH6bWoRW
	HspjbUdBQGOgV5aiFwHGCjFX2A+aKSxsgHSG5eO0/Z9InWVR83WoXR2VGkcimcj2j7Yei1UvFqb
	OGifzV/9s4Hl6ceYqojF6w80kf0V5vL4BNs5Uos2FV/dzbDuah0I+PKZE1e68CK8/7Hb29b2tN1
	nEFKj9onvGcIqEzugONUjEb4KZL4+y+mkHa+baXAB+2aB5FVs/vLQ=
X-Google-Smtp-Source: AGHT+IFxy8fT1dRrg4d0q8df8JdyXkj7/oD1PKfr96MRoX5/mmgZfjfDMVE7BSdSSFxAui9wnKIK0w==
X-Received: by 2002:a05:690c:7403:b0:788:1cde:cac9 with SMTP id 00721157ae682-78c33b5f13amr19558807b3.23.1765030016967;
        Sat, 06 Dec 2025 06:06:56 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c1b79942dsm27541147b3.49.2025.12.06.06.06.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 06 Dec 2025 06:06:56 -0800 (PST)
From: Shuran Liu <electronlsr@gmail.com>
To: song@kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	dxu@dxuuu.xyz,
	eddyz87@gmail.com,
	electronlsr@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	mathieu.desnoyers@efficios.com,
	mattbobrowski@google.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	sdf@fomichev.me,
	shuah@kernel.org,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf v4 2/2] selftests/bpf: add regression test for bpf_d_path()
Date: Sat,  6 Dec 2025 22:06:40 +0800
Message-ID: <20251206140640.3013-1-electronlsr@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAPhsuW7NTGkbVD97DQddwPEQR6PZgYQJ6c-JcEsNUg6ddnh3rA@mail.gmail.com>
References: <CAPhsuW7NTGkbVD97DQddwPEQR6PZgYQJ6c-JcEsNUg6ddnh3rA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Song,

I have done further testing and found that the initial version of
selftest (LSM version) could not reliably reproduce the issue on a
buggy kernel. I have now verified that the new fallocate test
correctly reproduces the bug.

I will be sending the v5 patch shortly. (This is our first patch
submission to the kernel, thank you for your patience :D )

Best regards,
Shuran Liu

