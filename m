Return-Path: <linux-kselftest+bounces-40053-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2AFB3838B
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 15:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74BE76870FC
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 13:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFD62522B5;
	Wed, 27 Aug 2025 13:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVcwEi0Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441851BCA07;
	Wed, 27 Aug 2025 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756300546; cv=none; b=jNz20e1cvAdBdE6MbV6aHY7DzIe4afkeRXIq0UN5KpN8FUZNbPpfHi9egCmOBzACipabrIcktF91plXe3moI9Dhhzr6wyiKKVO54juKghK0TYx3QJPyLkWjb9EwmmpX2KtDtZtjx4EwaUV0YOqBpMJ6lpjfBAHUKYYH0VQ+4oSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756300546; c=relaxed/simple;
	bh=z5OIZJ7GhqEF5gl7nMePuYERu1DlOwRV8Fee0JabGL4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=h5K3Zl9fl9Wvx7DifaxG0b9zJ6b9nJfn2mkGbvBlyUP+zggF1PSrqnEomphWLUnKwGhV6NfQttPimHhOycu2M15M4soSghQVDXKDk3ihAlZ49Ko7riDDGgAS9ggSKeqOQpbdBQaYw+YkSvu5F3BtCr5bvDVTpweBxhdNkbKRUZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVcwEi0Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFC8C4CEEB;
	Wed, 27 Aug 2025 13:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756300545;
	bh=z5OIZJ7GhqEF5gl7nMePuYERu1DlOwRV8Fee0JabGL4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jVcwEi0Z0G12ptig1RDRiybmxCbOub95s0gMZLoKkaxCSCohbLJZ1/klgDQLUUL62
	 KHTKb9LS866pIQJ/0fKij2SYDnwwNvKcBOjgR7u80RptVwGKGE5M6v8wLV3RuqNz0x
	 eH4ChTQvoHpiz0Dg7Iv9mLJCEDr5n+9EzVEsrk7kdIidISnu/6VYJC9CqpmB7Ha3Zk
	 hsO0ejNl7jdaJ44cY6ijcUqorbIulaPNc1wyoTQBA9t4tGES1wNWDAp43Vd1fsJy+n
	 5N/JNIJW/ACTOk2kZJ688BwaEnS2vkbhNQgBAUkhHtj35lwIMvQnGz07kll6+w0ikC
	 Q1N6xR8T0t7SA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: kwilczynski@kernel.org, kishon@kernel.org, arnd@arndb.de, 
 gregkh@linuxfoundation.org, shuah@kernel.org, 
 Christian Bruel <christian.bruel@foss.st.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
In-Reply-To: <20250804170916.3212221-1-christian.bruel@foss.st.com>
References: <20250804170916.3212221-1-christian.bruel@foss.st.com>
Subject: Re: [PATCH 0/3] Skip IRQ tests if irq legitimately is out of range
Message-Id: <175630054288.7421.16804697021603479134.b4-ty@kernel.org>
Date: Wed, 27 Aug 2025 18:45:42 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 04 Aug 2025 19:09:13 +0200, Christian Bruel wrote:
> 'pci_endpoint_test' fails for architectures allowing less than 32 MSI
> registers and that doesnt support MSI-X, avoid reporting false errors
> because of out-of-range irqs.
> 
> e.g for an EP configured with 8 msi_interrupts and no msix we can have
> 
>  ./pci_endpoint_test -t MSI_TEST
> 
> [...]

Applied, thanks!

[1/3] misc: pci_endpoint_test: Skip IRQ tests if irq is out of range
      commit: cc8e391067164f45f89b6132a5aaa18c33a0e32b
[2/3] misc: pci_endpoint_test: Cleanup extra 0 initialization
      commit: 384b1b29481e39aae8eb01240d1edf287c7a4145
[3/3] selftests: pci_endpoint: Skip IRQ test if irq is out of range.
      commit: 106fc08b30a2ece49a251b053165a83d41d50fd0

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


