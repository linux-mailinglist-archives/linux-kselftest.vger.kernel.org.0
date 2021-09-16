Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA56C40DCF3
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Sep 2021 16:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbhIPOje (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Sep 2021 10:39:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235955AbhIPOjc (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Sep 2021 10:39:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91E4A6120C;
        Thu, 16 Sep 2021 14:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631803092;
        bh=9THwCtBJYOWaA92FDr4unEhQt+b4WDannF0kKlmelkY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YuRZRoGWC0l7oFoFWECLSF16/+J1mmRN3HLzVg8jlL1NhLaMtONq2XZvGh0uXq42b
         ZsQwWlDjE4b5FjVBRtAEm3+Gz5tktXmqdAt+yzsO6RwSu2xGz7NP/fhJiegDDXwrRW
         efeGyIG+nDyEa0kqpQ49zjhKdERo54JgxuiSgb2XeHE4WJXwtGI0IqKWzNNffdzsRC
         oK2ArxOo0PF3g21QrCDZXoKoN+/uJpb3TAcGmtSBNvmAHBEI9f4zPENhkweOWe6H84
         /GGzsPpeZe1VcPoV3j/QePrvdRdNWs0upXFCV8CBtGo7nPR9ZmjuH0EsOYGqCvP6DB
         wtkaJjkbbAYJQ==
Message-ID: <dda727c928867ec5194703ab59c1dcfdcb4f6220.camel@kernel.org>
Subject: Re: [PATCH 01/14] selftests/x86/sgx: Fix a benign linker warning
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        linux-sgx@vger.kernel.org, shuah@kernel.org
Cc:     seanjc@google.com, bp@alien8.de, dave.hansen@linux.intel.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 16 Sep 2021 17:38:09 +0300
In-Reply-To: <84b02b56d45792971cabf8ba832a9862fb20990e.1631731214.git.reinette.chatre@intel.com>
References: <cover.1631731214.git.reinette.chatre@intel.com>
         <84b02b56d45792971cabf8ba832a9862fb20990e.1631731214.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2021-09-15 at 13:30 -0700, Reinette Chatre wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
>=20
> Pass a build id of "none" to the linker to suppress a warning about the
> build id being ignored:
>=20
>   /usr/bin/ld: warning: .note.gnu.build-id section discarded, --build-id
>   ignored.
>=20
> Link: https://lore.kernel.org/linux-sgx/20191017030340.18301-2-sean.j.chr=
istopherson@intel.com/
> Co-developed-by: Cedric Xing <cedric.xing@intel.com>
> Signed-off-by: Cedric Xing <cedric.xing@intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko

