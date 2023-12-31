Return-Path: <linux-kselftest+bounces-2536-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBE6820B30
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Dec 2023 12:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B395D1F2157E
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Dec 2023 11:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091C53209;
	Sun, 31 Dec 2023 11:08:28 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3976C33CE;
	Sun, 31 Dec 2023 11:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T2xDh31wMz4wd4;
	Sun, 31 Dec 2023 22:08:20 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>, Shuah Khan <shuah@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231215112456.13554-1-colin.i.king@gmail.com>
References: <20231215112456.13554-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] powerpc/selftests: Fix spelling mistake "EACCESS" -> "EACCES"
Message-Id: <170402086356.3311386.10584388086195315953.b4-ty@ellerman.id.au>
Date: Sun, 31 Dec 2023 22:07:43 +1100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, 15 Dec 2023 11:24:56 +0000, Colin Ian King wrote:
> There is a spelling mistake of the EACCES error name, fix it.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/selftests: Fix spelling mistake "EACCESS" -> "EACCES"
      https://git.kernel.org/powerpc/c/ba5b952ad5f52e58c0f288b9d5427ad734600568

cheers

