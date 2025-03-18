Return-Path: <linux-kselftest+bounces-29368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B91BA67AC6
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 18:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C76B716902A
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 17:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0763E20C481;
	Tue, 18 Mar 2025 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qp7TdAau"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71B313C908;
	Tue, 18 Mar 2025 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318593; cv=none; b=roxJEfTGpL4baLfpv+FLJiGMAgxPNZBCp6oLm4NMqKCeCs4pl9B1nXWtk1+uQEyN7wYLKlg2gp0ulQhnjeh0fXVfkQg3zPtxgDkcKdkwQHnCSsWYFOhPIX4wB4Id7cQ73lHpEqxrZsOSPksQ/0Gs1GtXN1sStH7QUh3t2YcQ0Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318593; c=relaxed/simple;
	bh=gmrcZ5rB2TM2oEe3o14+zF+adkQBnDRxyfXOlxllueY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1hxfOejWW8/+4jgJajHweGYZW7Ff/csLnyTYSSsr7vtzUjjs5PCn3VByh+mT6sqwkZFpBC6nQsmSFBElBmidFWi2Y31wARmLyj+kqpMuu2QHxGRSJDcSUhjUzpQXEUkpoZsXJk9AH3YrEzKdZkpnWR+cMYgPo0HFafuDgumW4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qp7TdAau; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884ECC4CEDD;
	Tue, 18 Mar 2025 17:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742318593;
	bh=gmrcZ5rB2TM2oEe3o14+zF+adkQBnDRxyfXOlxllueY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qp7TdAau7GK6jQNTBDkROM605foReTUvUqUgNHaqM2OgFWoafpXIVZmkcVVuOBuXx
	 YO/k61Y9OuIdCsUxLzKyfrmKsFxZNhap8gIR110YpGjHlpYijz/e7KEEdC7Eksl/8b
	 k2iRsP+juwOxQ6muDpiapjbKMGl7X+L/XLwmQbAAQDwuj2M7CICj3VXfWnoCWPgghw
	 3G0Vspo37iTV+MlTbzHom+ZHEberJExca5ucexWN6EQD+QUFyc+xN2/1pj2w5+uHVm
	 y2ILhbjX4DVfVgOQcol4hfZwLHmKIQlzFrHqZ3aoNY6n3JAPBx5WQNmP1apwLLhrZN
	 oFkCXOD2Q2VSA==
Date: Tue, 18 Mar 2025 17:23:08 +0000
From: Simon Horman <horms@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 05/12] mptcp: pm: add struct_group in
 mptcp_pm_data
Message-ID: <20250318172308.GJ688833@kernel.org>
References: <20250313-net-next-mptcp-pm-ops-intro-v1-0-f4e4a88efc50@kernel.org>
 <20250313-net-next-mptcp-pm-ops-intro-v1-5-f4e4a88efc50@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-net-next-mptcp-pm-ops-intro-v1-5-f4e4a88efc50@kernel.org>

On Thu, Mar 13, 2025 at 11:20:54AM +0100, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch adds a "struct_group(reset, ...)" in struct mptcp_pm_data to
> simplify the reset, and make sure we don't miss any.
> 
> Suggested-by: Matthieu Baerts <matttbe@kernel.org>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


