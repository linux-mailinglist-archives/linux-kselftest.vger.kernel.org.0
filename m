Return-Path: <linux-kselftest+bounces-28199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4A0A4DD18
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 12:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 232E1189A8E6
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 11:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9133C20127F;
	Tue,  4 Mar 2025 11:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXGhFT3m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C02200BA9;
	Tue,  4 Mar 2025 11:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089137; cv=none; b=hb5+u3IutXksX3QnYbxVrseF5nNM7saU7F+PLsgWrd5kR3IHJnuAcPHzfVZkARHN5ue8eHZxC4BAcJjy37FSbM9qh0yvV/CK+quRsq0ulVk1wk2azCoZgp6lCITuT8WceDqd4MT3j9xFBtwRKUSWGEbaUKIebGVd3Mei4B5+OXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089137; c=relaxed/simple;
	bh=EPAIERbCFgJfbsmMuNXCTV+TfVMyYMafuUDWHDGo/N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnYeZKtKdHeRuQ7jmSeX5Sqrq0IPB3lsZU7MtZ0RAWeqjpQbpeecMaYmLJRZmuSYutb/4js39+q5VOh3hiTXWJhqeuAmiu7TqsJlMZX11ayOVdDDiGlCPDcckb/Rt+pgKIeXidZ3DhJBDM5GrzhTcil91r/6Pb6nMJRqGtyuqlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXGhFT3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4114BC4CEE5;
	Tue,  4 Mar 2025 11:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741089135;
	bh=EPAIERbCFgJfbsmMuNXCTV+TfVMyYMafuUDWHDGo/N8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iXGhFT3meFed5hJxUcbB2eE45lqx91GkO3d2HtqH1rFJYc4gWdEf7ri3WmDdbjNf7
	 c9zb7/9HYSnutU3bjCHOjFwWXQYDrEMkfyDeDHRnnHarVrtL3pqRP17z1vcEkldN6R
	 Php0SKkRz7tkWM5rc94iZvPFvBxvkI60Jh6nEEgRCncMrJQgyCOvOq83UrLT0WJgGv
	 EbOBW4YRseDKfmHe5q9zmonNUycEqAsJSnSSxj1/oVWUR7kr8UzUVpUkopJNwdWlVC
	 HIZwwIY7/qQm65OwQszmdMFClz/yp2C6M0Spkh/GiVp0qvrTImKVSz15XSZ/VntFF8
	 M8rXuwZcTYFGA==
Date: Tue, 4 Mar 2025 11:52:11 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net-next v2 6/8] netconsole: add task name to extra data
 fields
Message-ID: <20250304115211.GC3666230@kernel.org>
References: <20250228-netcons_current-v2-0-f53ff79a0db2@debian.org>
 <20250228-netcons_current-v2-6-f53ff79a0db2@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228-netcons_current-v2-6-f53ff79a0db2@debian.org>

On Fri, Feb 28, 2025 at 04:50:22AM -0800, Breno Leitao wrote:
> This is the core patch for this whole patchset. Add support for
> including the current task's name in netconsole's extra data output.
> This adds a new append_taskname() function that writes the task name
> (from current->comm) into the target's extradata buffer, similar to how
> CPU numbers are handled.
> 
> The task name is included when the SYSDATA_TASKNAME field is set,
> appearing in the format "taskname=<name>" in the output. This additional
> context can help with debugging by showing which task generated each
> console message.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


