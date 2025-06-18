Return-Path: <linux-kselftest+bounces-35248-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0786DADE0D0
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 03:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 785C53A86D5
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 01:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64EE1946BC;
	Wed, 18 Jun 2025 01:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgJ+FTQW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5BF3A1DB;
	Wed, 18 Jun 2025 01:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750210939; cv=none; b=VLMa9U7Lgg9DXFtL4z/FDZf/pTuyji90UaE5HXKnUdwp5kaxGDmQlpdmra00HzC79SnkqmjVS96slopQ75Ee0zmCWJ/UqkKXcCpVUzQ9P2R8DYTrXLW/B3iFReo34JAFGAeDcDCY0nlWvGqG9JrqTQGNVzxvHPnW0vn9q/Ct5BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750210939; c=relaxed/simple;
	bh=FEyHRwPserWIMl0bLcXdk0UTDFt6hxGSfxHzMK/qJTc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=odIgD3vQ4++92lWbVSBAHmkc5sKxQOXwrdz1tzcs4IwY2NOjoA0pVa5XuRnwVkWadT/IrnThyWVHwyrQrTREw0c7a0XIJZB2pzr1ldhMWAetstknnjEWISV9WhCmuaQ+v01ipMVcSp8QeuBsH6J/WUl0OrHn18dvyxBShhjuXvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgJ+FTQW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6414EC4CEE3;
	Wed, 18 Jun 2025 01:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750210939;
	bh=FEyHRwPserWIMl0bLcXdk0UTDFt6hxGSfxHzMK/qJTc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qgJ+FTQW1nJrT+v/Lu3IbgYhL2oW9SwyCtb+5WptJLw0WyKvEADL68iJ1ZuFiDsfq
	 x022DVq8Uruvv815u2aFYcGURA9ob9plHAU+OYhZLZUS3BxirzdsqobnjErTZQJlUo
	 T4YRNBmGn7mXiWBMJJ0RsQRydeGJQd6ENgjFE4odjJCavUBrea3uuVw8s6Mh1vPh+T
	 U4Jt02xMj1SrR7c1LrQQmPt7z6v77ETLakS5lzptmAOL/s4Kj4FhJ4A8s7MZs0EYlk
	 5+H69iYMYGF00S1kH6HOOj+Q7gC0as28hKlhGExcDuVmPXYDqYPDQhxFrLtVtwRtby
	 D27ohDuhYaZQQ==
Date: Tue, 17 Jun 2025 18:42:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Gustavo Luiz Duarte <gustavold@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/5] netconsole: Add support for msgid in
 sysdata
Message-ID: <20250617184217.63c068f2@kernel.org>
In-Reply-To: <20250616-netconsole-msgid-v3-0-4d2610577571@gmail.com>
References: <20250616-netconsole-msgid-v3-0-4d2610577571@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Jun 2025 10:08:34 -0700 Gustavo Luiz Duarte wrote:
> This patch series introduces a new feature to netconsole which allows
> appending a message ID to the userdata dictionary.
> 
> If the msgid feature is enabled, the message ID is built from a per-target 32
> bit counter that is incremented and appended to every message sent to the target.

Breno, could you review the last 3 patches? 
These LGTM

