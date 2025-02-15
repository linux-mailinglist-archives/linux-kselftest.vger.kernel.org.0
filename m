Return-Path: <linux-kselftest+bounces-26722-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC23A370E6
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2025 22:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 223107A3404
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2025 21:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968031EA7E1;
	Sat, 15 Feb 2025 21:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="Zc1gej31";
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="jPDatS4A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D68170A37;
	Sat, 15 Feb 2025 21:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739655391; cv=none; b=QqfbMuz56sE2y8VaplKVeh2erLTGTyAgm6TbhjlActnMUIhuQXmwFeSoJSPPJjlQYpf7/qNsxW7ahX3P/Yo/zKLplGR1IM6Jqg2YRyLo8tcrEoWB3Y1yukPkJrNkFnNN1wdUP4NfcxDyTyQsry/c2Dcz89HD1jhVnrt+hcLP9PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739655391; c=relaxed/simple;
	bh=JDi0g6omxQd+IKSkcA6lJe9mXVfeSl4N342oHTRkfPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2nXGEqa/I7HfiO5Bg1/OoKKNr0JaSUZD/vDverdBUpZN8g12CvGk/T6V9uv+Cpjd7Hk6XDcTk8O3bew8epz2ZpibHItglXJbGWnagGKIUpUy/sb5atqb10VtOL/zCzJ4zawtHO9M1Q/aZ03HrIKxuEifEbVX2nqWVwc/GfCcWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=Zc1gej31; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=jPDatS4A; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: by mail.netfilter.org (Postfix, from userid 109)
	id 80A3160305; Sat, 15 Feb 2025 22:36:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1739655378;
	bh=IrOWNb052GzH1naxDxpdpOIqRG3ktl2xQkD48Z6xJ4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zc1gej31QLfGAa+/savVfMdcKI/NjhFTDjKLZ3ZxeowaC1IuKvmf/IehCHbaUujJ5
	 CMcCw56jENruI9UB9SJsFRosDhcEnnWUFn+uYLbZyfV5XfE43lCzLPjvCitAtBw59b
	 Mxffwb4NH2V+CmnCfqEpTPLrKAC0cg6rJasNR0jUdpwbWTPy2pwMG8DMN5+pUlff2t
	 AGUvXE+Vi4icJh77/zoHo5YAf4UvF1Lq2D+QYSWY8uQcDZrXSqH5JnMe0xCmigsEXT
	 ciO6QfytiTePDHp7dSJ0HZp29se6AvZ3XWgpxr8XFshV0xuNdYbf6VN+nD0Rgyi5Cd
	 mID5Fk6RLSQuQ==
X-Spam-Level: 
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 36FB0602C1;
	Sat, 15 Feb 2025 22:36:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1739655377;
	bh=IrOWNb052GzH1naxDxpdpOIqRG3ktl2xQkD48Z6xJ4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jPDatS4AHTupQiI76ipm/ryW3ULe1lu663zDIVKKWkURSNrRJfXjF0VUSWCr5jVDt
	 EPhP3QLKZjlpw3vxYnzebt+jvyIRCvwmaRBW+UQqkAWgmy8V7+QPbOiwKYzH2LHxXn
	 pw4Scu/QDjXNIcBvsWWmiNsdGP4Hi+zCGiAoraRiKUoy8RU2bIWisRj8X8BOq7njqX
	 4kZg6VJZuLytakAekHKn2sKkpJRnHOE++uqkny3bxNR6aKOIZrhykNkyeyz7nbYP6I
	 l1VZLj7FhuPzdiMmYOCr+9ZCWMsh11gSYlkzEz9tdudiGFRhOqNAgMIfc8FIWYSh6R
	 EOh754/r9GktQ==
Date: Sat, 15 Feb 2025 22:36:14 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Marcelo Moreira <marcelomoreira1905@gmail.com>
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kselftest@vger.kernel.org, ~lkcamp/patches@lists.sr.ht,
	netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] selftests: netfilter: Fix typo in
 conntrack_icmp_related.sh comment
Message-ID: <Z7EIzrGhBKmJwK1H@calendula>
References: <20250215003802.1466786-1-marcelomoreira1905@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250215003802.1466786-1-marcelomoreira1905@gmail.com>

Cc'ing netfilter-devel.

On Fri, Feb 14, 2025 at 09:37:25PM -0300, Marcelo Moreira wrote:
> Correct the typo "adress" to "address" in a comment in conntrack_icmp_related.sh
> to improve clarity.
> 
> Signed-off-by: Marcelo Moreira <marcelomoreira1905@gmail.com>
> ---
>  tools/testing/selftests/net/netfilter/conntrack_icmp_related.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/netfilter/conntrack_icmp_related.sh b/tools/testing/selftests/net/netfilter/conntrack_icmp_related.sh
> index c63d840ead61..f63b7f12b36a 100755
> --- a/tools/testing/selftests/net/netfilter/conntrack_icmp_related.sh
> +++ b/tools/testing/selftests/net/netfilter/conntrack_icmp_related.sh
> @@ -171,7 +171,7 @@ table inet filter {
>  }
>  EOF
>  
> -# make sure NAT core rewrites adress of icmp error if nat is used according to
> +# make sure NAT core rewrites address of icmp error if nat is used according to
>  # conntrack nat information (icmp error will be directed at nsrouter1 address,
>  # but it needs to be routed to nsclient1 address).
>  ip netns exec "$nsrouter1" nft -f - <<EOF
> -- 
> 2.48.1
> 

