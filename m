Return-Path: <linux-kselftest+bounces-27637-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50235A46848
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 18:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0181616FCC7
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 17:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888BC2253FC;
	Wed, 26 Feb 2025 17:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjW7gCmD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F052253F2;
	Wed, 26 Feb 2025 17:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740591706; cv=none; b=bmXThjZjp2Bmx+ZuErt95mjBXjmgQ/xmRittV+mD2lmkfGWhyBQIpkv1nYRbxbMtuExcmWS41WNPekMCUC6cyl1vQui39Zob1forwtHKk6+dgZjIFxrbwAnbRz4+hvpNdd9QzTfpfFEuYPuBLFn7XQJurhuscp/PqTCBDmfh6IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740591706; c=relaxed/simple;
	bh=HBYsF+DtPwbpO7fSpwd2+tnl+0gA+a+/Kij5QbTTcJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ys8mjCfYPMzWf+qKPVx86mQzSeid1mombj9msOQXlyl4cDy5I8fw5+CcU1QB5Cyc6RypbNtO1w80oglLf9SgvyJTZggOwxA0B+NY3oEPYnrIcw6sH4Dm+NSNsQO8BCeQKa+gckXpHy2vA4mDWYsZKoZV8nZqGu6IyiM5nvhJcmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjW7gCmD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38FAC4CED6;
	Wed, 26 Feb 2025 17:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740591706;
	bh=HBYsF+DtPwbpO7fSpwd2+tnl+0gA+a+/Kij5QbTTcJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qjW7gCmDd6hj7fSIb1ynTAHE97vWKNUPVITM7E79DKt2UytwCxr83sSnD5vb3xQW6
	 0FDQsW8bQhSSTJ9XBfm8acBUcnkh7xtajaK7mqPG/AqoseWHfomgxMvD8mhpEVNp4T
	 1A925Ls3m1v4bJgiFyKvJUjbO6wZBso/lPDOPe5uG8/NXLlSr645FYurf/32T3YlDj
	 LzU++Uau6YJQw2pE/0dkv6vPIxfM/uXD1Gi7b5eeb9tq5bR5/83gBWelBGQQY/UFy7
	 vqrgNeMVmbboQHt413BJ+NTaxGiB5xWTuQgU/FGSB1JbZbYdFiDp4WGLCaEyHLx1nA
	 0bjHFn5U3KlWA==
Date: Wed, 26 Feb 2025 10:41:43 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH V2 3/3] selftests: ublk: add ublk zero copy test
Message-ID: <Z79SV8gD1hah9PVD@kbusch-mbp>
References: <20250226155841.2489284-1-ming.lei@redhat.com>
 <20250226155841.2489284-4-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226155841.2489284-4-ming.lei@redhat.com>

On Wed, Feb 26, 2025 at 11:58:38PM +0800, Ming Lei wrote:
> +	struct io_uring_sqe *reg;
> +	struct io_uring_sqe *rw;
> +	struct io_uring_sqe *ureg;
> +
> +	if (!zc) {
> +		rw = ublk_queue_alloc_sqe(q);
> +		if (!rw)
> +			return -ENOMEM;
> +
> +		io_uring_prep_rw(op, rw, 1 /*fds[1]*/,
> +				(void *)iod->addr,
> +				iod->nr_sectors << 9,
> +				iod->start_sector << 9);
> +		io_uring_sqe_set_flags(rw, IOSQE_FIXED_FILE);
> +		q->io_inflight++;
> +		/* bit63 marks us as tgt io */
> +		rw->user_data = build_user_data(tag, op, UBLK_IO_TGT_NORMAL, 1);
> +		return 0;
> +	}
> +
> +	ublk_queue_alloc_sqe3(q, &reg, &rw, &ureg);
> +
> +	io_uring_prep_buf_register(reg, 0, tag, q->q_id, tag);
> +	reg->user_data = build_user_data(tag, 0xfe, 1, 1);
> +	reg->flags |= IOSQE_CQE_SKIP_SUCCESS;
> +	reg->flags |= IOSQE_IO_LINK;
> +
> +	io_uring_prep_rw(op, rw, 1 /*fds[1]*/, 0,
> +		iod->nr_sectors << 9,
> +		iod->start_sector << 9);
> +	rw->buf_index = tag;
> +	rw->flags |= IOSQE_FIXED_FILE;
> +	rw->flags |= IOSQE_IO_LINK;
> +	rw->user_data = build_user_data(tag, op, UBLK_IO_TGT_ZC_OP, 1);
> +	q->io_inflight++;
> +
> +	io_uring_prep_buf_unregister(ureg, 0, tag, q->q_id, tag);
> +	ureg->user_data = build_user_data(tag, 0xff, UBLK_IO_TGT_ZC_BUF, 1);

You don't have anything handling the unregister command's completion so
I think you want the IOSQE_CQE_SKIP_SUCCESS flag on it otherwise you get
an unexpected CQE for it.

