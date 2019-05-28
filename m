Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 301D72CCE0
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2019 19:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfE1RCy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 May 2019 13:02:54 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33122 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfE1RCy (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 May 2019 13:02:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5FEB341;
        Tue, 28 May 2019 10:02:53 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C71E83F59C;
        Tue, 28 May 2019 10:02:47 -0700 (PDT)
Date:   Tue, 28 May 2019 18:02:45 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     enh <enh@google.com>, Evgenii Stepanov <eugenis@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        kvm@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Subject: Re: [PATCH v15 00/17] arm64: untag user pointers passed to the kernel
Message-ID: <20190528170244.GF32006@arrakis.emea.arm.com>
References: <20190521182932.sm4vxweuwo5ermyd@mbp>
 <201905211633.6C0BF0C2@keescook>
 <20190522101110.m2stmpaj7seezveq@mbp>
 <CAJgzZoosKBwqXRyA6fb8QQSZXFqfHqe9qO9je5TogHhzuoGXJQ@mail.gmail.com>
 <20190522163527.rnnc6t4tll7tk5zw@mbp>
 <201905221316.865581CF@keescook>
 <20190523144449.waam2mkyzhjpqpur@mbp>
 <201905230917.DEE7A75EF0@keescook>
 <20190523174345.6sv3kcipkvlwfmox@mbp>
 <201905231327.77CA8D0A36@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201905231327.77CA8D0A36@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 23, 2019 at 02:31:16PM -0700, Kees Cook wrote:
> syzkaller already attempts to randomly inject non-canonical and
> 0xFFFF....FFFF addresses for user pointers in syscalls in an effort to
> find bugs like CVE-2017-5123 where waitid() via unchecked put_user() was
> able to write directly to kernel memory[1].
> 
> It seems that using TBI by default and not allowing a switch back to
> "normal" ABI without a reboot actually means that userspace cannot inject
> kernel pointers into syscalls any more, since they'll get universally
> stripped now. Is my understanding correct, here? i.e. exploiting
> CVE-2017-5123 would be impossible under TBI?
> 
> If so, then I think we should commit to the TBI ABI and have a boot
> flag to disable it, but NOT have a process flag, as that would allow
> attackers to bypass the masking. The only flag should be "TBI or MTE".
> 
> If so, can I get top byte masking for other architectures too? Like,
> just to strip high bits off userspace addresses? ;)

Just for fun, hack/attempt at your idea which should not interfere with
TBI. Only briefly tested on arm64 (and the s390 __TYPE_IS_PTR macro is
pretty weird ;)):

--------------------------8<---------------------------------
diff --git a/arch/s390/include/asm/compat.h b/arch/s390/include/asm/compat.h
index 63b46e30b2c3..338455a74eff 100644
--- a/arch/s390/include/asm/compat.h
+++ b/arch/s390/include/asm/compat.h
@@ -11,9 +11,6 @@
 
 #include <asm-generic/compat.h>
 
-#define __TYPE_IS_PTR(t) (!__builtin_types_compatible_p( \
-				typeof(0?(__force t)0:0ULL), u64))
-
 #define __SC_DELOUSE(t,v) ({ \
 	BUILD_BUG_ON(sizeof(t) > 4 && !__TYPE_IS_PTR(t)); \
 	(__force t)(__TYPE_IS_PTR(t) ? ((v) & 0x7fffffff) : (v)); \
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e2870fe1be5b..b1b9fe8502da 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -119,8 +119,15 @@ struct io_uring_params;
 #define __TYPE_IS_L(t)	(__TYPE_AS(t, 0L))
 #define __TYPE_IS_UL(t)	(__TYPE_AS(t, 0UL))
 #define __TYPE_IS_LL(t) (__TYPE_AS(t, 0LL) || __TYPE_AS(t, 0ULL))
+#define __TYPE_IS_PTR(t) (!__builtin_types_compatible_p(typeof(0 ? (__force t)0 : 0ULL), u64))
 #define __SC_LONG(t, a) __typeof(__builtin_choose_expr(__TYPE_IS_LL(t), 0LL, 0L)) a
+#ifdef CONFIG_64BIT
+#define __SC_CAST(t, a)	(__TYPE_IS_PTR(t) \
+				? (__force t) ((__u64)a & ~(1UL << 55)) \
+				: (__force t) a)
+#else
 #define __SC_CAST(t, a)	(__force t) a
+#endif
 #define __SC_ARGS(t, a)	a
 #define __SC_TEST(t, a) (void)BUILD_BUG_ON_ZERO(!__TYPE_IS_LL(t) && sizeof(t) > sizeof(long))
 

-- 
Catalin
