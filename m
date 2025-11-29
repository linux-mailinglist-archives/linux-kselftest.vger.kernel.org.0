Return-Path: <linux-kselftest+bounces-46729-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1565FC941BD
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Nov 2025 16:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE6203A5C44
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Nov 2025 15:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1A02080C8;
	Sat, 29 Nov 2025 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DscAM8cX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65FD156236;
	Sat, 29 Nov 2025 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764431767; cv=none; b=RYxFmZkvxz3mucH2lNglTysQo3ARHovtFsGAiIgOvru2J1j6WcIOF3XulmPbvmBnnA+ISzTLwGsMJLtCT9L8+lzwxCQ8BP0TBSjhNL5Ja0h66njuRSo1oop3+xtSmdNAqPN47B0tmh6VE5yAZQkzpuohEZ9GzYJwyDBRJKRm7uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764431767; c=relaxed/simple;
	bh=haEVv5DciOwH5GQfSxoUNlA+/dIrd0hJK5CWCuUSRhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lj7LKB1NjWwDKfxPkHiFz2Tu4QFoJRbpGs0iLSrtfTJyizaidU/xrFqEymUz4ZVDddbKtxZc1e8oc6FpvwM0/Uy1TL8KetFekSqZqyvMdnn2PEVHzxlfISCiunF26JkrX6gKJ/xDi0eVQeBDPuJKI7iHvZ6S+XrF+NtoV80Ppr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DscAM8cX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E666CC4CEF7;
	Sat, 29 Nov 2025 15:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764431767;
	bh=haEVv5DciOwH5GQfSxoUNlA+/dIrd0hJK5CWCuUSRhQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DscAM8cXEnvNq/CyxGIym9Oc++bHUCYJnnjyfEz+zzynZGBz87vFSG7Kgn7w1zuyx
	 baFiFjrKGNw8S+JT9V1jCc+zqn754hG0GkQi2JxgELSZSmizuG/Zw7q70754VjnQOZ
	 fKQnty0Yk7UvuldPMwSXVOP/j7RJ7A194T6l5dVKnraaoDGHM4eP8b51Qc9PAyVkfd
	 ysaOnDTgxE+UQBB1CNxIojS3XlAXxG5fcEB8QYH+PDC5NY3iijOYPYh4lGNHLZnBU6
	 Q8+OvwaWV9lADB6JqG0R/hDOoS1a55E1Qg2jp26vfYWWI2QRm9XXeOEfrcuv+081Ia
	 jwNJrqCs/dAnA==
Message-ID: <341a110e-7ba0-4846-abf4-5143042c8e80@kernel.org>
Date: Sat, 29 Nov 2025 08:56:06 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 net-next] selftests: ipv6_icmp: add tests for ICMPv6
 handling
Content-Language: en-US
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, shuah@kernel.org, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, davem@davemloft.net
References: <20251126201943.4480-1-fmancera@suse.de>
 <20251126201943.4480-2-fmancera@suse.de>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20251126201943.4480-2-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/25 12:19 PM, Fernando Fernandez Mancera wrote:
> Test ICMPv6 to link local address and local address. In addition, this
> test set could be extended to cover more situations in the future.
> 
> ICMPv6 to local addresses
>     TEST: Ping to link local address                                   [OK]
>     TEST: Ping to link local address from ::1                          [OK]
>     TEST: Ping to local address                                        [OK]
>     TEST: Ping to local address from ::1                               [OK]
> 

VRF based tests are needed as well to ensure this change works properly
with VRFs.


