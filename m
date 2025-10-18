Return-Path: <linux-kselftest+bounces-43474-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 062C8BEC35B
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 03:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 653FC3524E0
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 01:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D351C3BFC;
	Sat, 18 Oct 2025 01:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="ks4TLhHz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F397E5464D
	for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 01:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760750292; cv=none; b=PbAjAM4w0L5Djln5xYmCUBrrCS+8dOEp2ks1WLEt4TGDoeAEmkVpKRimJuCMJZ8BsSkaVD7ZUUBsMfn5Z33IAc5ts5ynHG0K5qq43Moi/QYNqWbsnjRJRRNfE4TWNOKofwN0FtK9mLvuWiNUoBIQnP7pYgqjSYrc6G8k/CdQcak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760750292; c=relaxed/simple;
	bh=DHdGUzF8HJaPv18p21SsIM1JCykWw1BNQ9xVxBJ/ey8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CqSM4WWnlDTiuIccLV7k5Dipjfaj+rWQOg+z/GkxyjGpwPCPu28ylohs0IWfjq+sv0//a9wqh/3J9VME8/HOyQ63kPV2wDu2wfKo2T+Y7p25RIpM74+diRidJXSmZB3GwNki+BSx86V9VaXP3Jk6w/6x2hmPYTSuzXn3+ojlqyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=ks4TLhHz; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7930132f59aso3475076b3a.0
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 18:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760750290; x=1761355090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNutzwJGGtfhc2UYuDqaLjoiYjQ+nZ6lcP1TgamaqJo=;
        b=ks4TLhHzMRGq5iK+19/UBva82f9kt72PVDnoEQdcYvPozcrn8A/O1q6e+8cci/mz9M
         lo/I7bRAOeS//Ycjd1Dvyyyz57WzCyX8HDPzUhT5DZZX0kP67tOSkkWUtbXP/phq2RV1
         BqtPHAT3Fr6IHoDUUupjumYLkqXimvaM7W53A0xFdzPnIaEqepc4+JwQVW+ByLcBqGYi
         uSz7dmUlzaZMk6amEsFMOCcgoUyRhmZUaXsvp6STm3ZT9RuI39YarVoEJiTyoXE3F+cT
         nbU06X7LRxxNrA9kauon7xYFVkaQMBbaXtujcdE7R38atvKualKVWhl6eOfbIZgXDaii
         IX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760750290; x=1761355090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNutzwJGGtfhc2UYuDqaLjoiYjQ+nZ6lcP1TgamaqJo=;
        b=ufJdtH7IGYyetuMrqqqsqFJnCBi2UwQtdU9BqXvZ8GTV3eeV/YOplsPRvPZzfRcrpG
         nlUNArVdgZGCS1kwZ7mB2HH4yWjXyME5/Bg/Ru0K3FR0s7kD3PGYxdUJYBdYKADgsBkS
         pEaZKdVSFenEdmFzKfFZU3q71l+BauNUocVx68cAjna2o1UoFH49U7iARfdc86Gn0rhI
         sHly9WWFe1hzEspXz4WvE+MznYQorwtr4MK7UGXqaAZjZBfLwn0h/DD8Rhzn+kG+toDM
         0FZY0io/thxsf8ZppVh6p2aNfEtBsLZ3Xmz+EB2Hl+rRqhIa86Jk+A4rrKjMqtB7fd5r
         CWMg==
X-Forwarded-Encrypted: i=1; AJvYcCX0Hu6HO1VYWFTbdwqA26IPZfvNabaL1uBB2IUCTJbk/2j+dgdUtOT49ozu94QX+Td78jOBd7JtWaoyleFKiZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqq06OvNuRUZdMKgvdEPet7Dp0EPLCs6U4dlQcmzXOK9hBWtib
	S0PZTVtygmUXEikZDd7hHQ8gT41zD5OXrAFmhgJbVJ8qrhHTnRzxkzYPzZ/5sWszxjg=
X-Gm-Gg: ASbGncvoAHKs30psQd6XdOc2RvZF0adx+aoToYZBHYbsHBW/yqVfpzLzjXulza7mxZw
	+svy8fFCNI7nHqmmjeakvfSUzCvY7RQlFDz3k/BcJRI6IXFvMb05Yy9vwcdDIsEs7xmjVZwZEJy
	8+dvhN2N6ci0hDHuk0bYnPG8sF0L+C0k5za1gDbZhLUWfklVfLnDsLl2L6Q22nm1PE+0x23EjCB
	YbsD98/IEDEo5jSjUzqz6SUeNQNgXs7YcaywqdXS8KmtFv1UqifRGBJA8UnWfucxxAXr0SS5JD8
	0jfUgWSNFDRxeC+9U8tj3FsaSGYC11adMcxwdWyy5ZYHSjUXYObhUjqH2EkV75dzJPVBSY5ybBE
	8T4URNSg5SFBw/ZIjWY20UZHXi4QjBMqAalcVq8/o/H8NYnq0yI6/nMCels1pOCbG4VWTSGYVN0
	gHR7BQ7WvISnTHgkFWabZOiAdWLfnphw+0ItoljYo=
X-Google-Smtp-Source: AGHT+IEBHV34cIapWYpa+I+Wb10CFFQfqZKuWXTnhL9/HOSdDCwgovS/YaG2tbmsQYyCsMNOIzfxAA==
X-Received: by 2002:a05:6a20:394c:b0:32b:6f9e:d62e with SMTP id adf61e73a8af0-334a85baeeemr7079575637.47.1760750289698;
        Fri, 17 Oct 2025 18:18:09 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a7664a462sm1122826a12.8.2025.10.17.18.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 18:18:09 -0700 (PDT)
Date: Sat, 18 Oct 2025 01:57:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern
 <dsahern@gmail.com>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH iproute2-next] bond: slave: print master name
Message-ID: <20251018015722.1df7f4a6@phoenix.lan>
In-Reply-To: <20251017030509.61794-1-liuhangbin@gmail.com>
References: <20251017030310.61755-1-liuhangbin@gmail.com>
	<20251017030509.61794-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Oct 2025 03:05:09 +0000
Hangbin Liu <liuhangbin@gmail.com> wrote:

> diff --git a/ip/iplink_bond_slave.c b/ip/iplink_bond_slave.c
> index c88100e248dd..55deaadf5fe2 100644
> --- a/ip/iplink_bond_slave.c
> +++ b/ip/iplink_bond_slave.c
> @@ -92,6 +92,17 @@ static void bond_slave_print_opt(struct link_util *lu, FILE *f, struct rtattr *t
>  	if (!tb)
>  		return;
>  
> +	if (tb[IFLA_BOND_SLAVE_MASTER]) {
> +		unsigned int ifindex = rta_getattr_u32(tb[IFLA_BOND_SLAVE_MASTER]);
> +
> +		if (ifindex) {
> +			print_string(PRINT_ANY,
> +				     "master",
> +				     "master %s ",
> +				     ll_index_to_name(ifindex));
> +		}
> +	}

You should use print_color_string(PRINT_ANY, COLOR_IFNAME, ...) here

