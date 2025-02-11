Return-Path: <linux-kselftest+bounces-26333-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E81BA30391
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 07:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03B393A3EDB
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 06:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B031E9900;
	Tue, 11 Feb 2025 06:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lw4B60uG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786AB1E8823;
	Tue, 11 Feb 2025 06:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739255161; cv=none; b=XKsp3/Sj/j4R955qHU+0Yl81YkUM00QS0EKFUUGkNiZI+i3hmTmX/cEtHkrMp75BSlIwXnTQ67ipKBBlzsP9L3RMZMIai3wNH4vZWyMAYzUBV6nBGB1eeB0eeURt4vbpmxuFTfZcwFW+qEqRaaMtXKYhM8T8QqXw5jtIh2LhSOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739255161; c=relaxed/simple;
	bh=S0NbAIcHcvY0e+8fQPYNhsOqY3NudlTCV4wB9XpcpD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzBLLQFo1pOHJMrkrfFIuAM7aCyrFYvGkfbMAF8IwcUihqNl5WYwi3/aN2XDt7B0jDNv0/KkFwsFvIKFmURWOstkdtDUqc8GSBVKZBibViXcm1Xhf63evDeOnwP2FH93oaDMMvIW5Ri/KlRlP3JJroAGmP/d+1jHHxc/gTo49lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lw4B60uG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2888C4CEDD;
	Tue, 11 Feb 2025 06:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739255161;
	bh=S0NbAIcHcvY0e+8fQPYNhsOqY3NudlTCV4wB9XpcpD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lw4B60uGgtEkyaeDRSoWneQuhVvUaDsrfMVcTZlvHL5gsx5/XctSePKHrCmVwowXz
	 6bQ+HR6P417DDJmG8I7efhrdVF9xWQ/nFEheddxMxlDz6uR+w/hMCsIZ8jXrtBtLfj
	 s/QwUSu1Wp0CUTVHsjC+QYZzT2EIwT7fQTJNMT1s=
Date: Tue, 11 Feb 2025 07:24:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yifei Liu <yifei.l.liu@oracle.com>
Cc: "shuah@kernel.org" <shuah@kernel.org>,
	"kevin.brodsky@arm.com" <kevin.brodsky@arm.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [External] : Re: [PATCH v2 Linux-6.12.y Linux-6.13.y 1/1]
 selftests/mm: build with -O2
Message-ID: <2025021143-limes-babble-e137@gregkh>
References: <20250204214723.1991309-1-yifei.l.liu@oracle.com>
 <2025020544-preview-worshiper-8539@gregkh>
 <C8A5840D-B312-40DC-A75D-3BA14614F8C4@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C8A5840D-B312-40DC-A75D-3BA14614F8C4@oracle.com>

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Mon, Feb 10, 2025 at 06:43:49PM +0000, Yifei Liu wrote:
> Hi Greg, 
> Yes, looks we only need this for linux-6.12.y. Maybe we could use the v1 version which does not include the linux-6.13.y tag. Or I can send a v3 with the linux-6.12.y only. 

As you know, we can't take patches for only older kernels and not newer
ones.  Please submit them for all relevant branches, AND test your
patches before you submit them so that they don't fail on our side, as
that just wastes our energy :(

thanks,

greg k-h

