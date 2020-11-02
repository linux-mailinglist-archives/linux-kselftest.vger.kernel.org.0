Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD77D2A3737
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Nov 2020 00:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgKBXgU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Nov 2020 18:36:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33808 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgKBXgU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Nov 2020 18:36:20 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604360177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kn1MrKipST+qlcwJ1zIgvlMXZ9bQBl36MnESiK2hrlI=;
        b=WO4xZRYluSA07JQGA2x48KKqtKPj2AWnFhCX4J0d8fVYBAG/4KfuMoZaJM3qbomnboDi2z
        CNoPbn8hgmPj4tBAxx2T73ZlDljs9QXge+xSx3bZ+PcwOR5lyCNU9REeAlg9L0b+LqMlOJ
        M+nbdv2UCJEEKxD3Vo67CqeXb6qvIcZzQJrF9+2il5iGZKzN+3o8X2F0Gk/EoJjsAsRUR+
        Lt0wWGitJ3ETEGTmjWfa5e52sdgqUPh7KLMFsyHVdGhHUOuP7R2zhChRleod61fGgukIXx
        i4TTKKT/QElFLXZav/sLONz5cABtcUlL8x6e++SDwGhZ6EqbgQJC25ccEH8AkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604360177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kn1MrKipST+qlcwJ1zIgvlMXZ9bQBl36MnESiK2hrlI=;
        b=bDzdY9iY6ze7qjRQmBLq0m9WmLMx8uKsr4lxx48nJ3PFoOuoYOrQ6mJCbDTbxc7miMSovu
        UMAas1KFWr29U4Dw==
To:     ira.weiny@intel.com, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, x86@kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH V2 00/10] PKS: Add Protection Keys Supervisor (PKS) support
In-Reply-To: <20201102205320.1458656-1-ira.weiny@intel.com>
References: <20201102205320.1458656-1-ira.weiny@intel.com>
Date:   Tue, 03 Nov 2020 00:36:16 +0100
Message-ID: <871rhb8h73.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 02 2020 at 12:53, ira weiny wrote:
> Fenghua Yu (2):
>   x86/pks: Enable Protection Keys Supervisor (PKS)
>   x86/pks: Add PKS kernel API
>
> Ira Weiny (7):
>   x86/pkeys: Create pkeys_common.h
>   x86/fpu: Refactor arch_set_user_pkey_access() for PKS support
>   x86/pks: Preserve the PKRS MSR on context switch
>   x86/entry: Pass irqentry_state_t by reference
>   x86/entry: Preserve PKRS MSR across exceptions
>   x86/fault: Report the PKRS state on fault
>   x86/pks: Add PKS test code
>
> Thomas Gleixner (1):
>   x86/entry: Move nmi entry/exit into common code

So the actual patch ordering is:

   x86/pkeys: Create pkeys_common.h
   x86/fpu: Refactor arch_set_user_pkey_access() for PKS support
   x86/pks: Enable Protection Keys Supervisor (PKS)
   x86/pks: Preserve the PKRS MSR on context switch
   x86/pks: Add PKS kernel API

   x86/entry: Move nmi entry/exit into common code
   x86/entry: Pass irqentry_state_t by reference

   x86/entry: Preserve PKRS MSR across exceptions
   x86/fault: Report the PKRS state on fault
   x86/pks: Add PKS test code

This is the wrong ordering, really.

     x86/entry: Move nmi entry/exit into common code

is a general cleanup and has absolutely nothing to do with PKRS.So this
wants to go first.

Also:

    x86/entry: Move nmi entry/exit into common code

is a prerequisite for the rest. So why is it in the middle of the
series?

And then you enable all that muck _before_ it is usable:

   Patch 3/N: x86/pks: Enable Protection Keys Supervisor (PKS)

Bisectability is overrrated, right?

Once again: Read an understand Documentation/process/*

Aside of that using a spell checker is not optional.

Thanks,

        tglx
