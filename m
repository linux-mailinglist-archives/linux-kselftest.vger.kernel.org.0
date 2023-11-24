Return-Path: <linux-kselftest+bounces-550-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 519D37F7790
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 16:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7FC0B2178A
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 15:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B782E851;
	Fri, 24 Nov 2023 15:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/9coW4P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3602E820
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Nov 2023 15:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FD1C433C9;
	Fri, 24 Nov 2023 15:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700839311;
	bh=LkiNqv5TLRrCYY7WjHKTVSxGQ3WbJ9zRq3lhvDB/w5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W/9coW4PM7Gn/qWd0DzK4w2XzWyxbcALDAI5l6Vb2vdjqsWYlAtul/n2JQvGF7Dw+
	 TnnrLfjHc+CfBl588vn97XZvfe81pG0VEKW3urDahIVGfzyJl+NNMPQvcDpwq536bV
	 G4wvoFiR0jBlzzHOjQSV0rcj2GClWAnaxHPRP4sVX0NdAzd7RlOpc1N5hsCkyNFE1h
	 Si4S82K8eiKJLRWLp3naWVPkbUF7M/NivzWBPjOygxZm5Om0Iu88zVZLY845pC+X5S
	 aCd0rn+ZN5BKKygLea38GB1+cbjvhtC0k4mPdyLOv/fXtDTULPpi+Ccn/0/xg+G0Kq
	 OYcW5MMQ48eLA==
Date: Fri, 24 Nov 2023 16:21:46 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/clone3: Make test names for set_tid test stable
Message-ID: <20231124-eintagsfliege-brennen-385b1d96defe@brauner>
References: <20231115-kselftest-clone3-set-tid-v1-1-c1932591c480@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231115-kselftest-clone3-set-tid-v1-1-c1932591c480@kernel.org>

On Wed, Nov 15, 2023 at 02:43:02PM +0000, Mark Brown wrote:
> The test results reported for the clone3_set_tid tests interact poorly with
> automation for running kselftest since the reported test names include TIDs
> dynamically allocated at runtime. A lot of automation for running kselftest
> will compare runs by looking at the test name to identify if the same test
> is being run so changing names make it look like the testsuite has been
> updated to include new tests. This makes the results display less clearly
> and breaks cases like bisection.
> 
> Address this by providing a brief description of the tests and logging that
> along with the stable parameters for the test currently logged. The TIDs
> are already logged separately in existing logging except for the final test
> which has a new log message added. We also tweak the formatting of the
> logging of expected/actual values for clarity.
> 
> There are still issues with the logging of skipped tests (many are simply
> not logged at all when skipped and all are logged with different names) but
> these are less disruptive since the skips are all based on not being run as
> root, a condition likely to be stable for a given test system.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

May I already acked this. Not sure,
Acked-by: Christian Brauner <brauner@kernel.org>

