Return-Path: <linux-kselftest+bounces-44082-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A62C0C02E
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 07:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 812CF3B4E7C
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 06:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399512BDC2B;
	Mon, 27 Oct 2025 06:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjcM76sN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F93827E06C;
	Mon, 27 Oct 2025 06:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761548201; cv=none; b=DF4RxrMlkWaXdFY5HhkNJG+uXSDulZ3nywJ0bPr2JC4rpb4YGk1+F+AIf3UrsZ/X+bOiBS0z7VNpT4T2vH5/ASyYIszadgDkxGE3zDKO6IvOx1YaC4S+BeqGuXrJDk3NOTWOmXGaBaf0oIrOJXlRquPSz7Yuhe0S5joEHXg26TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761548201; c=relaxed/simple;
	bh=3ozifgAZ+YfM5vcU5H0evJlif4ITKFrtPaxgfYBxwLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nssAU8I+i8IWrOcVQ591WbmgsFRzhGJ50upfoUYknJ3auE6f1BRwCB/rlywSXsjR5Ok7yciq/fg4xTHkvnnO0dU8Z+9DL7Atbn/s6vrGMjuaLKXhpBocR/9+oR7GfGU6n8B00Yh/Yb3MzHQ6bEBIxsi8+Q5cXZzUXQMQDMGiY6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjcM76sN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 119D6C4CEF1;
	Mon, 27 Oct 2025 06:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761548200;
	bh=3ozifgAZ+YfM5vcU5H0evJlif4ITKFrtPaxgfYBxwLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QjcM76sNfamPIkrR3/MQCp/WntCpIJUiYEpCpq/4JhWqemR1cIy/wJ+5sW7z4pqGo
	 X3TJ3oPuG8vIZ8sVRTz0+4JSnGa9GfwNZAYxHUc1xzqAA/aQMAGVc7dboRzEh6++GI
	 X7WZGWE8MHt7RjnZPj4Df4TM0UBatj+5rEJspgIubyJh03Hp1NR+qoR5NMvWnvDbqk
	 tUSLkhBsVUXu6eUq7/IYmNUdIpcwm0z1oA3jMsJmAT6PbZVKkSyaHZx+sAvqXP8Ih3
	 6Gm9Yrt8Y4A8kHpMb4UZ4KELC9L+yFyLWROSIOC6awBHXa2EjYJayQEA6BJkF1sOMK
	 RJoNydmW9CBow==
Date: Mon, 27 Oct 2025 08:56:32 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net,
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	masahiroy@kernel.org, ojeda@kernel.org, pratyush@kernel.org,
	rdunlap@infradead.org, tj@kernel.org
Subject: Re: [PATCH v8 8/8] memblock: Unpreserve memory in case of error
Message-ID: <aP8XoIJmefrhxpe4@kernel.org>
References: <20251024161002.747372-1-pasha.tatashin@soleen.com>
 <20251024161002.747372-9-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024161002.747372-9-pasha.tatashin@soleen.com>

On Fri, Oct 24, 2025 at 12:10:02PM -0400, Pasha Tatashin wrote:
>  	err |= fdt_end_node(fdt);
>  	err |= fdt_finish(fdt);
>  
> -	err |= kho_preserve_folio(page_folio(fdt_page));
> -
>  	if (!err)
> +		err = kho_preserve_folio(page_folio(fdt_page));

Since we are anyway changing the code here, lets use kho_preserve_pages()

-- 
Sincerely yours,
Mike.

