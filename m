Return-Path: <linux-kselftest+bounces-28097-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 550E5A4CD87
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 22:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EC9E163380
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 21:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C162135C7;
	Mon,  3 Mar 2025 21:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZ/aCFSM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C48A1F0992;
	Mon,  3 Mar 2025 21:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741037494; cv=none; b=MYBzB32UfuDT9Zs58ThIzsRTGHq11foldhOU8PE+00e55x7LJ32eBRJ6bBV5MvhF8niuqa5W7dH4vRDyDIy3jXkACecQm+ypiZraFPgUIq0i5UdaWHVgMf1j6yKGfDzGTunqQU4iYYer5ygAaGXqugpdi47YPZrKIYaOIjXhXNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741037494; c=relaxed/simple;
	bh=ETRUMQKmIBFpt5E8msuibm+B2S5O/FBn3l04fT8LYCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnXvw9N1lz4Yqd2ghqR/eB+iznTUEJzYby35WGcYv3jQ1CcPkHKbhdp0Bf5Wffhxyc8azLlk+UHnWVALQg1s8Y7O+B0Aq3hxYwQQtNsXrUpXKpcAlB15U835+61EOodd71NuINAm6aHvreo0nnuXytvZnyxO5Ur2HU24ILCAEIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZ/aCFSM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B64BC4CED6;
	Mon,  3 Mar 2025 21:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741037493;
	bh=ETRUMQKmIBFpt5E8msuibm+B2S5O/FBn3l04fT8LYCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KZ/aCFSMKJReR5xRqpVcehYg/NgmUa7hV+Wl+l5epQBXWeHiliKAmGKVNjHr2B5b3
	 LNrGKnGqq9K82sdPTzUkXyp2qsPNzt6rCaylGyX4rEHkPOGiQ/p2rEI85Rt/XbMKX7
	 LZQQgUTykaqFxnqm1gkpjOwzyfp74Ueuzk/IAdf5ro1Hyw59UxjvQMs/IRnf/fcpSM
	 JEinmlkmrVTVZVCvlQmgq7fvOUMkmoyFUhWt6b6VaaLE+MEQlpOoZrjMBR51yMlI89
	 X8YM0cbNCbpWOo/rs0Ei71168eXzLnGoRHkBfrqqhNOBl7zci4x+YS8h3DjGsYJp2k
	 FNu2nZJNPhwCw==
Date: Mon, 3 Mar 2025 14:31:31 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 02/11] selftests: ublk: fix build failure
Message-ID: <Z8Yfs9HCdcVn0N4Y@kbusch-mbp.dhcp.thefacebook.com>
References: <20250303124324.3563605-1-ming.lei@redhat.com>
 <20250303124324.3563605-3-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250303124324.3563605-3-ming.lei@redhat.com>

On Mon, Mar 03, 2025 at 08:43:12PM +0800, Ming Lei wrote:
> Fixes the following build failure:
> 
> ublk//file_backed.c: In function `backing_file_tgt_init´:
> ublk//file_backed.c:28:42: error: `O_DIRECT´ undeclared (first use in this function); did you mean `O_DIRECTORY´?
>    28 |                 fd = open(file, O_RDWR | O_DIRECT);
>       |                                          ^~~~~~~~
>       |                                          O_DIRECTORY
> 
> when trying to reuse this same utility for liburing test.

Looks good,

Reviewed-by: Keith Busch <kbusch@kernel.org>

