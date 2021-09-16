Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 795EB40DCF9
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Sep 2021 16:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbhIPOkf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Sep 2021 10:40:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238549AbhIPOkd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Sep 2021 10:40:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F80E611F2;
        Thu, 16 Sep 2021 14:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631803153;
        bh=9QV0gm/bE6CO5B0LrJ/SyOMLGG25gFlI9ZL3zKBkeA4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rrfIGHCsktRWoi28dSQp+Yyp3o6sZreHPHd3VFEtarPCsexK4bXJ9U6oJwUs+lzEq
         FwCxQCZ8AP2uLRQKWp6jkEzBSNBnDa2OiAo3aWnkNACCJgVaMmrvQNi7NA8fShfRAp
         PZFrMSl8ZuIOwOFm3pUq6GjNHnlPDJ5aB6zQa2G/6Oom4ga0VbPYIScLPzcIreM/9K
         4oHYendeVYyrszkApJI910jtK+CDmPaLFJ5BkwFzOkHxRamVjtWXbMQDQydjJwF7DJ
         kPQv/qZaW6WqK4GIdtnG/Enq3Riytnz/2ocZJSnfYJiu8RFtYeW6utcY+oLFy5g1Ac
         VRY7T8bstSm1w==
Message-ID: <21d412838f96f4b59b6e4a3aa6aaba1dd9f64044.camel@kernel.org>
Subject: Re: [PATCH 01/14] selftests/x86/sgx: Fix a benign linker warning
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        linux-sgx@vger.kernel.org, shuah@kernel.org
Cc:     seanjc@google.com, bp@alien8.de, dave.hansen@linux.intel.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 16 Sep 2021 17:39:10 +0300
In-Reply-To: <dda727c928867ec5194703ab59c1dcfdcb4f6220.camel@kernel.org>
References: <cover.1631731214.git.reinette.chatre@intel.com>
         <84b02b56d45792971cabf8ba832a9862fb20990e.1631731214.git.reinette.chatre@intel.com>
         <dda727c928867ec5194703ab59c1dcfdcb4f6220.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2021-09-16 at 17:38 +0300, Jarkko Sakkinen wrote:
> On Wed, 2021-09-15 at 13:30 -0700, Reinette Chatre wrote:
> > From: Sean Christopherson <sean.j.christopherson@intel.com>
> >=20
> > Pass a build id of "none" to the linker to suppress a warning about the
> > build id being ignored:
> >=20
> >   /usr/bin/ld: warning: .note.gnu.build-id section discarded, --build-i=
d
> >   ignored.
> >=20
> > Link: https://lore.kernel.org/linux-sgx/20191017030340.18301-2-sean.j.c=
hristopherson@intel.com/
> > Co-developed-by: Cedric Xing <cedric.xing@intel.com>
> > Signed-off-by: Cedric Xing <cedric.xing@intel.com>
> > Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> > Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>=20
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

... but I don't get the use "co-developed-by" tag in this. I mean
it's one line change. Maybe it should be "suggested-by"?

/Jarkko
