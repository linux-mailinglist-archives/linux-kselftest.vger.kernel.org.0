Return-Path: <linux-kselftest+bounces-22811-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3B29E327E
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 04:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 833C216788E
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 03:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69711632FE;
	Wed,  4 Dec 2024 03:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ii6x+FkU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0DB15A848;
	Wed,  4 Dec 2024 03:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733284685; cv=none; b=rKHrwZ19xQxIN9zObF2PuMnRSltV1KBB+tNqcbQh+C+h8YLY4/yc1kQNm8VpfD8OvJ/woCWeDPAgm6/f88+tjBUBDzrKxybjkQh2kdhc2kJzufjO/xMJYAcKuTjjsaD7axIkAD8/zhvZO4eZSR9sg7dauJ0PYILLHlpzHAERblc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733284685; c=relaxed/simple;
	bh=xtf6cRMGg/v4YxtVrJ+hXnfp1h83uTHFUC+7RsCsZW8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kB9WiJxNvj9/4qzYHvJFoK1ef2NoaFs5UF7ZTmS+JpygxdaeVH/HNffuoiZuaTjh9Bxk9G5xyM5XTcSt1ecPnh2RE7uOrPCYQTU6ml2JOiE0mhRypmchC88qC1mMkL4OEZwe2Mi4xpnUDKD8q1Hoyyks7P/8/2AW4a58XohiFlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ii6x+FkU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7A6C4CED1;
	Wed,  4 Dec 2024 03:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733284685;
	bh=xtf6cRMGg/v4YxtVrJ+hXnfp1h83uTHFUC+7RsCsZW8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ii6x+FkUdWyJbp7wogZIpsFc+gjlFnOmLP+dOvZv1phl1g1SJqwLyWsF2DrCnZkXr
	 ephAIdEC+chD7WTCBgsxaMugs5/RGwadctlPcQrQzejwkIUC+aNviGM5V631BNc+Iw
	 PZbovERsO7lCmy+cMwDjO69XhgSiZJ7+EFLTCzPcIezd+hllRMbTxC52v7c5UwtVXo
	 5vWCyZbRnQqsNvmdoNePa1oC3337+pokHeO6OI7MRmsTypLNbLZM4WF4LRqcbpkC1h
	 7Box5mbgdd6DuqNUCZIHNO7H3qfrVNbNol26Hd4yQI7x5AgsV92qUMGuwyN7HJbb3V
	 wtNvZ63DdVoAQ==
Date: Tue, 3 Dec 2024 19:58:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vfedorenko@novek.ru>, Frantisek
 Krenzelok <fkrenzel@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Apoorv Kothari <apoorvko@amazon.com>, Boris Pismenny <borisp@nvidia.com>,
 John Fastabend <john.fastabend@gmail.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>, Marcel
 Holtmann <marcel@holtmann.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v4 2/6] tls: implement rekey for TLS1.3
Message-ID: <20241203195804.3325ed4b@kernel.org>
In-Reply-To: <8db5c0e8ccb9e989d8dfd3bf78939fd63e6ac062.1731597571.git.sd@queasysnail.net>
References: <cover.1731597571.git.sd@queasysnail.net>
	<8db5c0e8ccb9e989d8dfd3bf78939fd63e6ac062.1731597571.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Nov 2024 16:50:49 +0100 Sabrina Dubroca wrote:
> This adds the possibility to change the key and IV when using
> TLS1.3. Changing the cipher or TLS version is not supported.
> 
> Once we have updated the RX key, we can unblock the receive side. If
> the rekey fails, the context is unmodified and userspace is free to
> retry the update or close the socket.
> 
> This change only affects tls_sw, since 1.3 offload isn't supported.

Acked-by: Jakub Kicinski <kuba@kernel.org>

