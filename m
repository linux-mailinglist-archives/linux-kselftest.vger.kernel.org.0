Return-Path: <linux-kselftest+bounces-37795-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 587CDB0D0C3
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 06:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F1E1888447
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 04:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A5B1D90A5;
	Tue, 22 Jul 2025 04:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFtutMOc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547A91922ED;
	Tue, 22 Jul 2025 04:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753157047; cv=none; b=smclvtzo5C3QEgPCecQR1QvPh7WwItw2FgnX5mQzTqxq80ULxPkZKofxipXkNcwMRkcLRG62c7Llol4aShdv6OUbeRYNe3tpNC6F3WpXZtv/Zi0Iq7S2j9qh+F1WqOnjM3U2nGoIDQ/J7PMEZRkb18roDtGpzvVta4+Hot719yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753157047; c=relaxed/simple;
	bh=sWFLbPKdRogAeCO4NDj6dit5DKLdo1elGMqIueuiDEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WUwSBAR5a7ncwuM5+dRjrjlwdyzEQtoa/8T5C9ZfaDbeanjl/CLidOvcp1BaH2TuFGNCOuEfXMc19o/RTzj7FfA0+I7bjdVxjFw64Y+G+gBiKP5c5BKSjFseqAfQzbKg9DMFelGy9xRrfPuZL6LEFUF1FPVNoUJ+eEjJ3g3fzNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFtutMOc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ACF4C4CEEB;
	Tue, 22 Jul 2025 04:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753157046;
	bh=sWFLbPKdRogAeCO4NDj6dit5DKLdo1elGMqIueuiDEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jFtutMOcE08vlLS9/lRevrcIsHge7VHmofxu2T4R5WSoI1A5XNViB10nmON/w4rov
	 NA2sZwDB2idnXsjS2OFybxYKwIxOwd3Fl1JTue6LxK8b0xRShnH8xfoT+wyK7qO79g
	 Ly4vyFgQ/j/3GpBlgOl0pPGmNU/59hdT3SrPgACAdLlxImd8NH7oQ5Bv6X2Obh+dfU
	 GGBDJ+W/2qoygGPTZVFKdEL65T26w0eo/SZvUNlinY60ZCj3xqLhDquUCLHBU1PR2d
	 zzzaLuouyx7zKl2pzXNYxQaRNVuBgwIfdvGUBZROzf6jdbXvV2GBxcWkf3UkYY5sDj
	 J0C0uQ2UxszgQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 16/22] selftests/damon/sysfs.py: generalize DAMOS schemes commit assertion
Date: Mon, 21 Jul 2025 21:04:02 -0700
Message-Id: <20250722040402.56960-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250721200922.79b34a049af4a02947c716ee@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 21 Jul 2025 20:09:22 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Sun, 20 Jul 2025 10:16:46 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > DAMOS scheme commitment assertion is hard-coded for a specific test
> > case.  Split it out into a general version that can be reused for
> > different test cases.
> > 
> 
> This patch has the same name as [18/22].  I renamed this patch to
> 
> "selftests/damon/sysfs.py: generalize DAMOS access pattern commit assertion"
> 
> and altered its changelog to
> 
> : DAMOS scheme access pattern assertion is hard-coded for a specific test
> : case.  Split it out into a general version that can be reused for
> : different test cases.

Thank you for catching this and fixing on your side, Andrew!  But, the actual
change that this patch is adding is the assertion of individual scheme, while
the 18th patch for the assertion of multiple schemes.  That is, this patch has
actually wrong subject, but the changelog is correct.

So, could you please make the changelog back to the original, but fix the
subject by 's/schemes/scheme/', as below?

"selftests/damon/sysfs.py: generalize DAMOS scheme commit assertion"

Sorry for making things unnecessarily complicated.  Please let me know if there
is anything that I can help for this.


Thanks,
SJ

[...]

