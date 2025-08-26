Return-Path: <linux-kselftest+bounces-39942-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06503B35AF8
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 13:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD9467A9CDC
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 11:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76262BD00C;
	Tue, 26 Aug 2025 11:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="H83eRGoG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C7B29C347
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 11:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756206998; cv=none; b=g1a090nAovrMQkNFRFpBdOmY+CEYdDc3f87jNVkay20rIOivp1x++t2ZAMZp22x/GnGNIFjny+Hr8aYj+0C/VR4rXnAQ24q/t59Dd8XPUhUbclugQMphWPJ5a98ER9WfbiciZkns/fhqOgMgkY9CONSeYU5GClua9UPyeSWrMqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756206998; c=relaxed/simple;
	bh=yyy+tp7DVsKMlqKjk/ic7QU8sIfNpj2aIPwr9puSl1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MaZL8HLE5zlEVGcyCllfZrGRLkQVGaR/HnAcmAjgkt+HzXjQTkDFKeFFJiG5Nmacypve/zeqkAN81EMNeJBI1Uy37VPqgbRnrj8bAnr5QbJlnazANoYzrA9c7gFzgbQSL4NHajBe9yDgxCT5Dw4KRVd/O+oHpA9r+J/J/AhkETw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=H83eRGoG; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-53b17531009so1646067e0c.3
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 04:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756206996; x=1756811796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13+ZKZHSBSlxWn30sItlJ+MHDakals4QsmIVvRoAzjM=;
        b=H83eRGoGNY278qSQi65SbooVk5gT9LpLTQJvMug50o3zZcqDfnNYDcGowmeNKWlATR
         l4wZnhn1J7EGUL7vUsc2CxQlQcj+amztcE+ZlXHVpAJ+8sxlrjsIrzYPXGgMMm2z9xED
         MucM+lan4qmfRce/mA9tvh4/Uq9WrhmP53zwzrn/sBvS15wnWVr3rn61GVm35+ENc3cQ
         nbWq7UBnDYSV8ccszezxJamFhsHq2Skq2Yy6reyR4Rxz6OM4MYVb0FFgzsUlJmQ3HtlR
         LIP8IIXP+YdIgpR1BJNRT9UKyQHqduIJAsYsPNk7QHp9ZTgqV8jQ9m8LWBnujpGpdAs6
         n/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756206996; x=1756811796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13+ZKZHSBSlxWn30sItlJ+MHDakals4QsmIVvRoAzjM=;
        b=obR6xTKtdes5HL95zrRXyMuZo1RUAve0M1qbqqG1Umd/9lT089YEneqjER3/Oosk0K
         swdfsKEGMuLRNiajXk1NH9PppwhZVXru/7KEsLE0ubyW5XDBIXJBNhG3RaB8yjmOvOez
         MwKhZpbvVlzRKIp6uKVLovPqAbb6l56utT3oe8UNWNpL/OvuKebdXjFSKvaSm0HAi+A8
         Q2swm8B8qLvU+TeYxR/dScPcookDEeZ8bK2G6lIUmfJfmoi4vSztRQlHKTDw99HqMEzm
         iuHxeWSHOGqBDi1XEfyIR7GgQb+S4YWhLN18WrrLDBSwkCRuKlzxG08ygJiG9RjciH6a
         pJcg==
X-Forwarded-Encrypted: i=1; AJvYcCWW1NAn6dYhm9Q5XW2SSEInIHXdrlZiC4VMEqt39GPtr4gqXyzI88VydNfovV3hCeOEwnEVt8/MDAJWK1nxyPU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye1QTroVt2k/Fomdc6vJh002M8WzU9Q2BUFmMvo0rQBNtrkYKT
	gW4razE+q9B5Vy71eWTuQsgo4ltdqWzII6gi1ZhEeI/EqFzftMC5wcKld1ycHsT6bHTrU+aBerG
	qdReC6hq2y/JPaDFcRbO9rqn5pq0xLHBnYsp1oz3lrg==
X-Gm-Gg: ASbGncsPPpNptDL0FuGBakSmwnKbrxVEsyM2Qvo/gQVpID26umySaBwKUVQQYrmbVyh
	Z3r+r3JTmHewjsVxCTGDJ4HqsvEAn+Ns/LHsB/1ESrCw9IwJrQIs9KbXQIUHh3h5ZeDfiLgfLd6
	M0FqcwE3f5DuBokmAGAqD1D05OYHgkzl6Do9e4THbdgKKmHKxsXTC7LpCL4LEzB7gGalXs3YDuW
	5zXNLzZzBDj4fKDMBPyxfkdx0zc
X-Google-Smtp-Source: AGHT+IGLaaBqvt9XEIIWuswTMJEBdxRtANkhP57jHYijW1XkWUKRdvmPkMfPUDOxuY2T7Sa3m41LxDUj4QvUufum+Qo=
X-Received: by 2002:a05:6122:181d:b0:531:4041:c4c5 with SMTP id
 71dfb90a1353d-53c8a31dcbfmr3724012e0c.7.1756206995825; Tue, 26 Aug 2025
 04:16:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825145719.29455-1-linyongting@bytedance.com>
In-Reply-To: <20250825145719.29455-1-linyongting@bytedance.com>
From: Yongting Lin <linyongting@bytedance.com>
Date: Tue, 26 Aug 2025 19:16:24 +0800
X-Gm-Features: Ac12FXyevGRiMRbSCI3kYQcBRsrIKMzDdG8JNBs40u_qfXYdnjAXQlDzDqSNaHc
Message-ID: <CAFuXZ_WHC6XtzuiuS-VBpAotOs+e5Z3toHY0jES3+hCXC9AUgw@mail.gmail.com>
Subject: Re: [PATCH 0/8] Add selftests for mshare
To: anthony.yznaga@oracle.com, khalid@kernel.org, shuah@kernel.org, 
	linyongting@bytedance.com
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	akpm@linux-foundation.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for the mistake! I accidentally sent each individual patch twice,
except for the cover letter. Please ignore the duplicated ones at the
bottom.

Apologies again for the noise.

Yongting Lin.

On Mon, Aug 25, 2025 at 10:57=E2=80=AFPM Yongting Lin <linyongting@bytedanc=
e.com> wrote:
>
> Mshare is a developing feature proposed by Anthony Yznaga and Khalid Aziz
> that enables sharing of PTEs across processes. The V3 patch set has been
> posted for review:
>
> https://lore.kernel.org/linux-mm/20250820010415.699353-1-anthony.yznaga@o=
racle.com/
>
> This patch set adds selftests to exercise and demonstrate basic
> functionality of mshare.
>
> The initial tests use open, ioctl, and mmap syscalls to establish a share=
d
> memory mapping between two processes and verify the expected behavior.
>
> Additional tests are included to check interoperability with swap and
> Transparent Huge Pages.
>
> Future work will extend coverage to other use cases such as integration
> with KVM and more advanced scenarios.
>
> This series is intended to be applied on top of mshare V3, which is
> based on mm-new (2025-08-15).
>
> Yongting Lin (8):
>   mshare: Add selftests
>   mshare: selftests: Adding config fragment
>   mshare: selftests: Add some helper function for mshare filesystem
>   mshare: selftests: Add test case shared memory
>   mshare: selftests: Add test case ioctl unmap
>   mshare: selftests: Add some helper functions for reading and
>     controlling cgroup
>   mshare: selftests: Add test case to demostrate the swaping of mshare
>     memory
>   mshare: selftests: Add test case to demostrate that mshare doesn't
>     support THP
>
>  tools/testing/selftests/mshare/.gitignore |   3 +
>  tools/testing/selftests/mshare/Makefile   |   7 +
>  tools/testing/selftests/mshare/basic.c    | 108 ++++++++++
>  tools/testing/selftests/mshare/config     |   1 +
>  tools/testing/selftests/mshare/memory.c   |  82 +++++++
>  tools/testing/selftests/mshare/util.c     | 251 ++++++++++++++++++++++
>  6 files changed, 452 insertions(+)
>  create mode 100644 tools/testing/selftests/mshare/.gitignore
>  create mode 100644 tools/testing/selftests/mshare/Makefile
>  create mode 100644 tools/testing/selftests/mshare/basic.c
>  create mode 100644 tools/testing/selftests/mshare/config
>  create mode 100644 tools/testing/selftests/mshare/memory.c
>  create mode 100644 tools/testing/selftests/mshare/util.c
>
> --
> 2.20.1
>

