Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65AB40DC85
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Sep 2021 16:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237383AbhIPOPU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Sep 2021 10:15:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235546AbhIPOPU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Sep 2021 10:15:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27C1A61164;
        Thu, 16 Sep 2021 14:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631801639;
        bh=Ou7RB0CenpTfBy4XOy0FC9vI/kcV12k9i3vow3MfXfk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PayO4Q/7lTE0w+RUF1dqMtjN7OalRzVPBLuechm5DKitA/8NOqWti8a0fBSpg9fVP
         mpYM7qwJjVWnnE1Q+dGYqKntjXbcrOlDNvRyzxtV2bV5z6P7gR7trPEEoRLwvGriW1
         Nxe+XYki75Eg/SgFPV8aa2i5fwywDy78gQLhV7aqkYgnH0fdKkMV4m+83+1HPY0q0l
         fkkdabsCY3lBV59Qo5E6k+Hy3LYdSqsS3K+rcxyMssSXc98bgxSOzzHg8qcGqWKbkv
         w3g8rgU+xC4ygh3PxvcNLvukaZFJAdFDuwUwhnWa2WWm64fL6ltqtrktM73Rpuxr4+
         CjyQbuGQrVIWA==
Message-ID: <d6bf64ddd231f766aafe6f7775ba9fb2adad95c5.camel@kernel.org>
Subject: Re: [PATCH 00/14] selftests/sgx: Oversubscription, page permission,
 thread entry
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        linux-sgx@vger.kernel.org, shuah@kernel.org
Cc:     seanjc@google.com, bp@alien8.de, dave.hansen@linux.intel.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 16 Sep 2021 17:13:57 +0300
In-Reply-To: <cover.1631731214.git.reinette.chatre@intel.com>
References: <cover.1631731214.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2021-09-15 at 13:30 -0700, Reinette Chatre wrote:
> Hi Everybody,
>=20
> This series consists out of outstanding SGX selftests changes, rebased
> and gathered in a single series that is more easily merged for testing
> and development, and a few more changes added to expand the existing test=
s.
>=20
> The outstanding SGX selftest changes included in this series that have al=
ready
> been submitted separately are:
>=20
> * An almost two year old patch fixing a benign linker warning that is sti=
ll
>   present today:
>   https://lore.kernel.org/linux-sgx/20191017030340.18301-2-sean.j.christo=
pherson@intel.com/
>   The original patch is added intact and not all email addresses
>   within are valid.
>=20
> * Latest (v4) of Jarkko Sakkinen's series to add an oversubscription test=
:
>   https://lore.kernel.org/linux-sgx/20210809093127.76264-1-jarkko@kernel.=
org/
>=20
> * Latest (v2) of Jarkko Sakkinen's patch that provides provide per-op
>   parameter structs for the test enclave:
>   https://lore.kernel.org/linux-sgx/20210812224645.90280-1-jarkko@kernel.=
org/
>=20
> The reason why most of these patches are outstanding is that they depend
> on a kernel change that is still under discussion. Decision to wait in:
> https://lore.kernel.org/linux-sgx/f8674dac5579a8a424de1565f7ffa2b5bf2f8e3=
6.camel@kernel.org/
> The original patch for this kernel dependency continues to be included in
> this series as a placeholder until the ongoing discussions are concluded.
>=20
> The new changes introduced in this series builds on Jarkko's outstanding
> SGX selftest changes and adds new tests for page permissions, exception
> handling, and thread entry.

Thanks for including my patches into this! It's a good idea that
we carry single series (and probably least confusing to Shuah).

Thank you.

/Jarkko
