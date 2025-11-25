Return-Path: <linux-kselftest+bounces-46409-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD5DC832E6
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 04:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 88213349C60
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 03:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7491C2324;
	Tue, 25 Nov 2025 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2eTr1Ej"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F20C3FFD;
	Tue, 25 Nov 2025 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764040228; cv=none; b=DrIp7UyTuWo6dsIbL0kQ56CLE5lU4vI1nu5m/6coxJyLCEG6h4UavKr5TuPB8Y1QJCaucVAbUEoHtoEnog7SrxPBdHZ+U9EiJQER97EK+e1+btazel0dF99Eq9GqTtAqY1cq6H4x+F9I8I73wq4Gmbf1ieljQSyYllasNhEBHuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764040228; c=relaxed/simple;
	bh=ZUG97EAaAxCmkWG0aHzQ8X/iKEpLZ0v41OhZOYC+580=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cqHekyXt6+NIZNz0PIV2JZoMMs4kdq1poLZ8K2V0SyyuuYzvJlZnHDq/v7+NVLm/f+CYY3DR7fH2+VmB2dx5j8BJgjj3ALWqum0O/CvOVbZIMmNvcoZgz08Sy8GyJG3XhZzmGrqje0PaHbHlvfwvyn19K9XLS1V7bN2BuNpQ+Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2eTr1Ej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FECC116C6;
	Tue, 25 Nov 2025 03:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764040228;
	bh=ZUG97EAaAxCmkWG0aHzQ8X/iKEpLZ0v41OhZOYC+580=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p2eTr1Ej19yEdwm7gdPV7ypmWPc6TLOJx9YmFSm0Yj3VLKEbrg2OVkf8IDmzBW7Lf
	 UrI9J/AupXkLsttunkCquxJY3gUKJ5GeixzKiThga7mYyqfUa56RvC5Tktn0vv5rXf
	 TDAl68g6leW5hBz29e0x/WhTolL5tOT1UKcwyZJlhwt53Nag3B5UAfqlmg+iPuhTM0
	 FxfMHgB/3Z2QgfmSCWQm115vlUI3NnLgO6uPcvzwRqusbuKAKe8mzmmdqDogVG+UJP
	 b6w6e6CliYZa244bOBHQmI2KU5UrC4IUfTNgnCsiFA46FJzZ+n+j8LfAta/jtooG/i
	 C+4IGMcEEDBWw==
Date: Mon, 24 Nov 2025 19:10:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Gal Pressman
 <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Cosmin Ratiu"
 <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Mark Bloch
 <mbloch@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next V2 0/6] selftests: drv-net: Fix issues in
 devlink_rate_tc_bw.py
Message-ID: <20251124191026.1438551c@kernel.org>
In-Reply-To: <20251123171015.3188514-1-cjubran@nvidia.com>
References: <20251123171015.3188514-1-cjubran@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Nov 2025 19:10:09 +0200 Carolina Jubran wrote:
> This series fixes issues in the devlink_rate_tc_bw.py selftest and
> introduces a new Iperf3Runner that helps with measurement handling.

Sorry to report but patch 2 doesn't apply cleanly.
-- 
pw-bot: cr

