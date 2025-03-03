Return-Path: <linux-kselftest+bounces-28096-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BB6A4CD86
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 22:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 459431889265
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 21:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CC41F03EE;
	Mon,  3 Mar 2025 21:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVGU6yGm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ABA757EA;
	Mon,  3 Mar 2025 21:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741037480; cv=none; b=S/7Iiv816dEau2zBjg+ZHIbiOV3bqhJqhz5tRFUI2YkcgNhwJUkaESvgFrDSen5e+5z5/VLb7gmJzkK89+SlF6ZFWq35xHX4aUN7+zwJ4GkKCzySePH+yuPLLvDX4fWEtrG9maBpcL4R7TKyL9Tr94Fy75Xd0lpY5Fh40AdXpuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741037480; c=relaxed/simple;
	bh=aCnPt9SmUvATGqSdUaCPGDqfBZToDWnpEVFyMBvp4NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHH7FlKbpZXM9m5gfg2Qajq2KVZ4BPNvQxjrU1E7bIooKNQd9cnvyr80NbEo4R/uvrJGIn22DpSwWBX8v88HggPBVrwY4noqXWMYHFvfHJmX7XWMwDK33UAMcasK8R1rWO07E0zbg8l1u4d2oLZjjVcSu7DdZzbEtgBM94vfb24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVGU6yGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7175CC4CED6;
	Mon,  3 Mar 2025 21:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741037479;
	bh=aCnPt9SmUvATGqSdUaCPGDqfBZToDWnpEVFyMBvp4NM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YVGU6yGmj/Bn54JDkpz9RPqP09kZqt2qPK2wTrCnBB3sejfWHhrq1EQdJGoDrruV1
	 etaqT3lJ7PDJWAIk9YfLNH/ByZWL0jUZQngOuY08esuQirooB1u8ERY8wKv+9TuAiP
	 NXUv5bEoNxSaMKLJ00FIyQfGs6eHHmUcXt67lSMdYgQMpF2QinF9/3QeZodJJ07d3r
	 HKy0l9DdQN4rhGZCKZ58f0Fu2gD1jZ+K4sbaD8SaldZYN4pgt+FlXbL3dfTOue0Lob
	 FB7bUBz/l6z69y/1/kR/ktABqCBhfipVyq76H+hwEuSCvJWZ2Z5aUUR86H8GRf4SVR
	 QCDn6hHn/J8TQ==
Date: Mon, 3 Mar 2025 14:31:17 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 01/11] selftests: ublk: make ublk_stop_io_daemon() more
 reliable
Message-ID: <Z8YfpQwwMKCWJ_NR@kbusch-mbp.dhcp.thefacebook.com>
References: <20250303124324.3563605-1-ming.lei@redhat.com>
 <20250303124324.3563605-2-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303124324.3563605-2-ming.lei@redhat.com>

On Mon, Mar 03, 2025 at 08:43:11PM +0800, Ming Lei wrote:
> Improve ublk_stop_io_daemon() in the following ways:
> 
> - don't wait if ->ublksrv_pid becomes -1, which means that the disk
> has been stopped
> 
> - don't wait if ublk char device doesn't exist any more, so we can
> avoid to rely on inoitfy for wait until the char device is closed
> 
> And this way may reduce time of delete command a lot.

Looks good,

Reviewed-by: Keith Busch <kbusch@kernel.org>

