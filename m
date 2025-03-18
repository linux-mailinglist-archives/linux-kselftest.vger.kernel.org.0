Return-Path: <linux-kselftest+bounces-29373-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD38A67AE7
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 18:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91AC43B2689
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 17:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A360213227;
	Tue, 18 Mar 2025 17:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaFP+2w3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65559212FB5;
	Tue, 18 Mar 2025 17:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318687; cv=none; b=XgrMTAHn8sVk5HXNLE5EPgXYgeqNT+2z9PpP1hX4vIN8z2V+P214D21ra4x+IR5URzwvcAi2hOPQDqMwGAqAIXo68XVK9OvA7SptxO4Nta8o3GZrC8nzt2nJQC2baC373ulaITPRybqsUWkRg7IW8Pmm9095Nt/GX2C5ATBO8VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318687; c=relaxed/simple;
	bh=eNRbARQO/NBxSyCIsware9rPcDE+jN9aIN0gNmZNUCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjicJSU1t4ETdFUT7ocUHvQ2bSaKUf3UUxu7Wi0fJqJYioHe8Ep1CNBdAFM02IT8xoo72NYDiKyRjPKXEqatooPTHvbCY5G4ZKpmfb0v2bL9qIWN76LX/RaNPokqi+LrXJV5bvYfSpWZ7nAAy4e+cY6qrr44reoYuatfvPouMzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaFP+2w3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E981C4CEF1;
	Tue, 18 Mar 2025 17:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742318687;
	bh=eNRbARQO/NBxSyCIsware9rPcDE+jN9aIN0gNmZNUCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gaFP+2w3qgEdItTl2UZohZFyTyMYJOqvthTdGKooymXJqnHgmTzIbluHaL3QMZ/G7
	 /mZSDYTVxe6g7qtEQrP0mliV9AcB5p/zsAz5JwhXNNEO0e+a+n80si4K4Ijsmqf63X
	 m87bfX4c+3+LJZb4hptpkMttCY9L+DIFG4aYjZjxxDZEJFabVz/+zcZrw9f1pP5Lr6
	 QlyXyquGUY9LpkhETRX7CJr4Ua35RQ/nTRy44CWryXr5Aj2o8Fuu6LXZp5Ll00+0w/
	 qYbXADXD4q1f8WITWiBRQORpJAOmPkmLFpdVxkYIhmSTNUMjG40TM1vi6wxxc7y8t2
	 D3V1xPLj8e6mw==
Date: Tue, 18 Mar 2025 17:24:42 +0000
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
Subject: Re: [PATCH net-next 10/12] mptcp: sysctl: map pm_type to path_manager
Message-ID: <20250318172442.GO688833@kernel.org>
References: <20250313-net-next-mptcp-pm-ops-intro-v1-0-f4e4a88efc50@kernel.org>
 <20250313-net-next-mptcp-pm-ops-intro-v1-10-f4e4a88efc50@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-net-next-mptcp-pm-ops-intro-v1-10-f4e4a88efc50@kernel.org>

On Thu, Mar 13, 2025 at 11:20:59AM +0100, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch adds a new proc_handler "proc_pm_type" for "pm_type" to
> map old path manager sysctl "pm_type" to the newly added "path_manager".
> 
> 	path_manager		   pm_type
> 
> 	MPTCP_PM_TYPE_KERNEL    -> "kernel"
> 	MPTCP_PM_TYPE_USERSPACE -> "userspace"
> 
> It is important to add this to keep a compatibility with the now
> deprecated pm_type sysctl knob.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


