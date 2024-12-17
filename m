Return-Path: <linux-kselftest+bounces-23439-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BABE9F4000
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 02:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DD9B163BAA
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 01:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3864D8CE;
	Tue, 17 Dec 2024 01:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3OBWA+C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B207A2837A;
	Tue, 17 Dec 2024 01:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734398978; cv=none; b=ew+2/9JFqLkN4Tjt95uCnpsIm5TUKuB0hIGc1TvDOKEtHmoUAvcr8JaA0TUc+WNQUZtdsmOCYm1+FMtwdKEmToqUEv8PVgTE3UuYePJLNzsYGQ3SLk7ATdHF45IetkZXcn/0g16MMx7hglobA30ULTYZahptWoJzKmlACupVTco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734398978; c=relaxed/simple;
	bh=05ionxI3KsEGqCdtDd73IYlz2pycNNXjkGCtNme9dXE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bFTFSN5CDtGvhIWi4TomNf8dqKPValI6tb0sc1M4sV7CrTjwMrxaUxgQ+8mSXNp4aMUbkrbj5rOr6VllC3Xb783/s0wNl5wLc72ZahJGHw09lNnlUmOx955xQVjA7FeEBHgOhiyvGXfE3nuIooA5XUlaBq8s7JCMXnUq1i7RFts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3OBWA+C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDF7C4CED0;
	Tue, 17 Dec 2024 01:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734398978;
	bh=05ionxI3KsEGqCdtDd73IYlz2pycNNXjkGCtNme9dXE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s3OBWA+COxQSV32k+bpazAnkMXbjGhaLh5+K3P/ERmYnRa8xKb89OFxpCHUmwRZsV
	 TA1B7IZuHEGOpsmWzKs0YQ3IGSk+B37O+mwczYLA0XrgrEijPNRjOWWc0SB43Ryv9h
	 md0eGegoTJmGig6FKwGz2OqB0V6rIGXvHm7G5DN2yCCpd5sSlqBikVcdP/cWb7IY30
	 XLxX8b7C4JlOUqrxX/luDPfZSZ5oemYsm3fT/j9pOnjPkqqgKR1q5tmgVRhYSjKP24
	 xL4a94DMkc859cHgn3KTJQM5glTHgeOLWDCNVSG5w19o3NHZnS5Eq/I6JOu2Wc2NU1
	 sgPfxfZZWsZpA==
Date: Mon, 16 Dec 2024 17:29:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net 5/5] selftests: net-drv: stats: sanity check netlink
 dumps
Message-ID: <20241216172936.3223273e@kernel.org>
In-Reply-To: <877c7zvqe4.fsf@nvidia.com>
References: <20241213152244.3080955-1-kuba@kernel.org>
	<20241213152244.3080955-6-kuba@kernel.org>
	<877c7zvqe4.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Dec 2024 11:53:58 +0100 Petr Machata wrote:
> > +        if ifindex not in parsed:
> > +            parsed[ifindex] = {"rx":[], "tx": []}
> > +        parsed[ifindex][entry["queue-type"]].append(entry['queue-id'])  
> 
> BTW setdefault() exists for exactly these add-unless-already-exists
> scenarios:
> 
>         parsed_entry = parsed.setdefault(ifindex, {"rx":[], "tx": []})
>         parsed_entry[entry["queue-type"]].append(entry['queue-id'])
> 
> Sometimes this can be used to inline the whole expression, such as
> mydict.setdefault(key, []).append(value), but that would be unwieldy here.

Ack, I used setdefault() initially but it made the line too
incomprehensible. Too many things get indexed at once..

