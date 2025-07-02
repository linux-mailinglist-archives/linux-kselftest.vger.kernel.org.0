Return-Path: <linux-kselftest+bounces-36356-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 395BDAF6180
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 20:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E293177B3B
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 18:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0981F3196BC;
	Wed,  2 Jul 2025 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuqXrhsf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D1731550C;
	Wed,  2 Jul 2025 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751481571; cv=none; b=eh/JQXBxedyd39Cy7ir8j1Nnaf2y9RgJxEndfOERHnauae5liZBz73F5ERy0OZk3Wdoo9w15Qyqk2SR2/F1adLJQgeEGcVKY5aF1YJ5kUAWeQGexoq9pD4pAyzM97znssaKtcaN2Ek+aecyuyAfcJk1EHVC3w9OVa4LntMgVPPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751481571; c=relaxed/simple;
	bh=Hk/yMndM8BuCC8/IHGbpmThZz1wOCyYlk9OLaRYNimU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X3ZpdnW2n4thACwUaMtLieu/OimW8HBEMpohTRjOwqPaqyvRqSMSAMWJxid1klgLyTzbVCvveBSLCdtD5pSTpDxSekXYa65ZUC6HOr5xn3FVEeEmZONJhsrv/vc9JdArYwIatcl3NGNd6H+eWMd3U59d9q+4QPKMBjaCIfyJ+h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuqXrhsf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B41C4CEEF;
	Wed,  2 Jul 2025 18:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751481571;
	bh=Hk/yMndM8BuCC8/IHGbpmThZz1wOCyYlk9OLaRYNimU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iuqXrhsfisQQcE6YWOd9I2+dJrXlIAy1mO7fgv4ppnyhseqU+Y+zzyDcX5Y6D+eLh
	 ukfY8PakZhgfbNYmQ49BgBhDyqK/Yf9VM2JDCiiIUPckzT8pGbi3mTUxzoCRC4pJzM
	 d1L5aOWRJngeo0lgy87xtLPe7k1b89RBEZpg7cC7jZ/Xy2wKcOTd6jo0stjmMpv+KV
	 fVNn7cxcuPilgatTlZnPIduWLZ5oSw02YuTiKSSF247/t67uumHVx5dZvIbE9RuBxD
	 CZWypwRnANILBTJgWkVEtqVpiU3z5a56gL+8ZFGz1IJ6kPOCKYeoWmJ2t6ShtAtbzB
	 0CbsiVK0O5znA==
Date: Wed, 2 Jul 2025 11:39:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, shuah@kernel.org, almasrymina@google.com,
 sdf@fomichev.me, jdamato@fastly.com, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 net-next] selftests: devmem: configure HDS threshold
Message-ID: <20250702113930.79a9f060@kernel.org>
In-Reply-To: <20250702104249.1665034-1-ap420073@gmail.com>
References: <20250702104249.1665034-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Jul 2025 10:42:49 +0000 Taehee Yoo wrote:
> The devmem TCP requires the hds-thresh value to be 0, but it doesn't
> change it automatically.
> Therefore, make configure_headersplit() sets hds-thresh value to 0.

I don't see any undoing of the configuration :(
The selftest should leave the system in the state that it started.
We should either add some code to undo at shutdown or (preferably)
move the logic to the Python script where we can handle this more
cleanly with defer().
-- 
pw-bot: cr

