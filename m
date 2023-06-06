Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667DD724A40
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 19:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238769AbjFFRax (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 13:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238767AbjFFRax (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 13:30:53 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3065E1701
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Jun 2023 10:30:47 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-650c8cb68aeso3681251b3a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jun 2023 10:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686072646; x=1688664646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/6vAJn3a3KISHT8UtPfE8rCcxDqLecC+K/Bswfmc3cg=;
        b=xKwNOSXAy/mAacxGKGUyv4x6SJmn0ha0YRP82RY1R/dk7rvb9rFUlavan41Fxo6E9x
         pISxCMcI4O07qu9QmhC/xBDe9/nUvb/OD2B1UaoSl+q1gjMRg4TTybzxru/yozrNZnMj
         wf3JaX3X9HntgvVq8qIisiM0gzcXir9yCUsZAwkR08oY6UgMxvhCjZBeYJhlf1Li5OQ1
         75ncKzcX2vc1gu9MnDS9c5o0L60wP1aOvtU7D9s2eZh+SXGghkVpVofUbz62xJ++CEtM
         muoz/drqTgyeHISx0UfXDAbfkc01oqqRCAZjsQLCXwU2TZVONQl8X6ZGvlpfFks80w7I
         K5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686072646; x=1688664646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6vAJn3a3KISHT8UtPfE8rCcxDqLecC+K/Bswfmc3cg=;
        b=Tsuclpj+fMZ95MorJyYRbywUeHB32m5Dy9FA5BzF+anoHDJVr/1iAUSYUWDLdvBDCj
         L3Gd45+MUjAZ0HPA5Bv3zpU2GfQGZtXk5NDWoZQDVdOoa3XImD3nuJAj8dNvbbVWAu87
         5fcyBxLqnAJQF3hbK4BBLepm6jspr6CXGCq2Bz1Llf0hUe0T9Z34wBSowMMFFqhR7Dso
         FDaZb8aYvMacQSIBY7Mg/+t40lfSTCy9JqMc1RFmT9zKe1iK7kj9lxUIzlXPp45cEQQ7
         4/7Ftn6XeqSo/uBwJyfKALhv4pJEDtFad2n0qa1im+nS+wQ8BID0IJrv3EeONUFgKVMz
         O3hg==
X-Gm-Message-State: AC+VfDxWQfPf/2KNbOdk8wdBZjS9CeWhzewzVIa6/toe3sJqiYF3jrpR
        /fQ9Io0YCP/WK3FKcLruNKPoBA==
X-Google-Smtp-Source: ACHHUZ7Ihf8OXprV7uWFwxEk8IAjkO4PklZxhrEJNeRyfQGSzen5mICvmPpTPx0ELjM0ALxCXZ3riA==
X-Received: by 2002:a05:6a00:2e01:b0:64a:7723:fe04 with SMTP id fc1-20020a056a002e0100b0064a7723fe04mr1618217pfb.4.1686072646318;
        Tue, 06 Jun 2023 10:30:46 -0700 (PDT)
Received: from google.com (139.11.82.34.bc.googleusercontent.com. [34.82.11.139])
        by smtp.gmail.com with ESMTPSA id a25-20020aa78659000000b00625037cf695sm7096619pfo.86.2023.06.06.10.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 10:30:45 -0700 (PDT)
Date:   Tue, 6 Jun 2023 10:30:42 -0700
From:   Vipin Sharma <vipinsh@google.com>
To:     Zhi Wang <zhi.wang.linux@gmail.com>
Cc:     maz@kernel.org, oliver.upton@linux.dev, james.morse@arm.com,
        suzuki.poulose@arm.com, yuzenghui@huawei.com,
        catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
        aleksandar.qemu.devel@gmail.com, tsbogend@alpha.franken.de,
        anup@brainfault.org, atishp@atishpatra.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, seanjc@google.com, pbonzini@redhat.com,
        dmatlack@google.com, ricarkol@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/16] KVM: arm64: Document the page table walker
 actions based on the callback's return value
Message-ID: <ZH9tQjQk7QLyhUQR@google.com>
References: <20230602160914.4011728-1-vipinsh@google.com>
 <20230602160914.4011728-10-vipinsh@google.com>
 <20230605223520.00007fbd.zhi.wang.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605223520.00007fbd.zhi.wang.linux@gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 05, 2023 at 10:35:20PM +0800, Zhi Wang wrote:
> On Fri,  2 Jun 2023 09:09:07 -0700
> Vipin Sharma <vipinsh@google.com> wrote:
> 
> > Document what the page table walker do when walker callback function returns
> > a value.
> > 
> > Current documentation is not correct as negative error of -EAGAIN on a
> > non-shared page table walker doesn't terminate the walker and continues
> > to the next step.
> > 
> > There might be a better place to keep this information, for now this
> > documentation will work as a reference guide until a better way is
> > found.
> >
> 
> After reading the whole patch series, I was thinking it might be a good
> time to improve the way how the visitor function and page table walker
> talk to each other. The error code is good enough before, but its meaning
> seems limited and vague when the visitor function wants to express more about
> what exactly happens inside. I am not sure if it is a good idea to continue
> that way: 1. found a new situation. 2. choosing a error code for visitor
> function. 3. walker translates the error code into the situation to
> handle. 4. document the error code and its actual meaning.
> 
> Eventually I am afraid that we are going to abuse the error code.

I agree that error numbers are not sufficient and this will become more
difficult and cumbersome for more cases in future if we need different
behavior based on different error codes for different visitor functions.

> 
> What about introducing a set of flags for the visitor function to express
> what happened and simplify the existing error code?
> 

If I understood correctly what you meant, I think this will also end up
having the same issue down the line, we are just switching errors with
flags as they might not be able to express everything.

"Flags for visitor function to express what happened"  - This is what
ret val and errors do.

"simplify existing error code" - is very dependent on visitor function
and caller of page table walker. This might not be able to cover all
cases for the future also.

But I do agree that just error code is not sufficient and it will make
it harder to handle shared vs non-shared walkers combinations with error
code from visitor functions and walk action (exit, next, retry).

One approach I can think of is:
Based on the visitor function return value, a page table walker will do
3 things:

1. Move to next SPTE
2. Retry the current SPTE
3. Exit the walk and return the exit code.

struct kvm_pgtable_walker{}  will have two more callbacks
1. kvm_pgtable_walk_ignore(int ret, enum kvm_pgtable_walk_flags):
   This will be set for each walker and walker will check with this
   function intead of kvm_pgtable_walk_continue().

2. kvm_pgtable_walk_retry(int ret, enum kvm_pgtable_walk_flags):
   This will be set for each walker and walker will use it in
   __kvm_pgtable_walk()  on the return value of __kvm_pgtable_visit() to
   retry again.

This will allow to have walker be more configurable and each type of
walker can be customized based on vistor function return and
shared/non-shared walker combo. It will avoid having visitor function
error code handling same in all walkers.

Below is a sample code (compile tested only):

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 850d65f705fa..9a96f61208af 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -243,6 +243,10 @@ struct kvm_pgtable_visit_ctx {
 
 typedef int (*kvm_pgtable_visitor_fn_t)(const struct kvm_pgtable_visit_ctx *ctx,
 					enum kvm_pgtable_walk_flags visit);
+struct kvm_pgtable_walker;
+typedef bool (*kvm_pgtable_walker_action_fn_t)(const struct kvm_pgtable_walker *walker,
+					      int ret);
+
 
 static inline bool kvm_pgtable_walk_shared(const struct kvm_pgtable_visit_ctx *ctx)
 {
@@ -258,6 +262,8 @@ static inline bool kvm_pgtable_walk_shared(const struct kvm_pgtable_visit_ctx *c
  */
 struct kvm_pgtable_walker {
 	const kvm_pgtable_visitor_fn_t		cb;
+	const kvm_pgtable_walker_action_fn_t	ignore;
+	const kvm_pgtable_walker_action_fn_t	retry;
 	void * const				arg;
 	const enum kvm_pgtable_walk_flags	flags;
 };
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 364b68013038..28891a9c463a 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -180,6 +180,12 @@ static int kvm_pgtable_visitor_cb(struct kvm_pgtable_walk_data *data,
 	return walker->cb(ctx, visit);
 }
 
+static bool kvm_pgtable_walk_retry(const struct kvm_pgtable_walker *walker,
+				      int r)
+{
+	return false;
+}
+
 static bool kvm_pgtable_walk_continue(const struct kvm_pgtable_walker *walker,
 				      int r)
 {
@@ -231,7 +237,7 @@ static inline int __kvm_pgtable_visit(struct kvm_pgtable_walk_data *data,
 		table = kvm_pte_table(ctx.old, level);
 	}
 
-	if (!kvm_pgtable_walk_continue(data->walker, ret))
+	if (!data->walker->ignore(data->walker, ret))
 		goto out;
 
 	if (!table) {
@@ -242,14 +248,14 @@ static inline int __kvm_pgtable_visit(struct kvm_pgtable_walk_data *data,
 
 	childp = (kvm_pteref_t)kvm_pte_follow(ctx.old, mm_ops);
 	ret = __kvm_pgtable_walk(data, mm_ops, childp, level + 1);
-	if (!kvm_pgtable_walk_continue(data->walker, ret))
+	if (!data->walker->ignore(data->walker, ret))
 		goto out;
 
 	if (ctx.flags & KVM_PGTABLE_WALK_TABLE_POST)
 		ret = kvm_pgtable_visitor_cb(data, &ctx, KVM_PGTABLE_WALK_TABLE_POST);
 
 out:
-	if (kvm_pgtable_walk_continue(data->walker, ret))
+	if (!data->walker->ignore(data->walker, ret))
 		return 0;
 
 	return ret;
@@ -260,19 +266,25 @@ static int __kvm_pgtable_walk(struct kvm_pgtable_walk_data *data,
 {
 	u32 idx;
 	int ret = 0;
+	kvm_pteref_t pteref;
 
 	if (WARN_ON_ONCE(level >= KVM_PGTABLE_MAX_LEVELS))
 		return -EINVAL;
 
 	for (idx = kvm_pgtable_idx(data, level); idx < PTRS_PER_PTE; ++idx) {
-		kvm_pteref_t pteref = &pgtable[idx];
+retry:
+		pteref = &pgtable[idx];
 
 		if (data->addr >= data->end)
 			break;
 
 		ret = __kvm_pgtable_visit(data, mm_ops, pteref, level);
-		if (ret)
+		if (ret) {
+			if (data->walker->retry(data->walker, ret)) {
+				goto retry;
+			}
 			break;
+		}
 	}
 
 	return ret;
@@ -343,6 +355,8 @@ int kvm_pgtable_get_leaf(struct kvm_pgtable *pgt, u64 addr,
 	struct leaf_walk_data data;
 	struct kvm_pgtable_walker walker = {
 		.cb	= leaf_walker,
+		.ignore = kvm_pgtable_walk_continue,
+		.retry	= kvm_pgtable_walk_retry,
 		.flags	= KVM_PGTABLE_WALK_LEAF,
 		.arg	= &data,
 	};
@@ -474,6 +488,8 @@ int kvm_pgtable_hyp_map(struct kvm_pgtable *pgt, u64 addr, u64 size, u64 phys,
 	};
 	struct kvm_pgtable_walker walker = {
 		.cb	= hyp_map_walker,
+		.ignore = kvm_pgtable_walk_continue,
+		.retry	= kvm_pgtable_walk_retry,
 		.flags	= KVM_PGTABLE_WALK_LEAF,
 		.arg	= &map_data,
 	};
@@ -533,6 +549,8 @@ u64 kvm_pgtable_hyp_unmap(struct kvm_pgtable *pgt, u64 addr, u64 size)
 	u64 unmapped = 0;
 	struct kvm_pgtable_walker walker = {
 		.cb	= hyp_unmap_walker,
+		.ignore = kvm_pgtable_walk_continue,
+		.retry	= kvm_pgtable_walk_retry,
 		.arg	= &unmapped,
 		.flags	= KVM_PGTABLE_WALK_LEAF | KVM_PGTABLE_WALK_TABLE_POST,
 	};
@@ -582,6 +600,8 @@ void kvm_pgtable_hyp_destroy(struct kvm_pgtable *pgt)
 {
 	struct kvm_pgtable_walker walker = {
 		.cb	= hyp_free_walker,
+		.ignore = kvm_pgtable_walk_continue,
+		.retry	= kvm_pgtable_walk_retry,
 		.flags	= KVM_PGTABLE_WALK_LEAF | KVM_PGTABLE_WALK_TABLE_POST,
 	};
 
@@ -958,6 +978,8 @@ int kvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
 	};
 	struct kvm_pgtable_walker walker = {
 		.cb		= stage2_map_walker,
+		.ignore		= kvm_pgtable_walk_continue,
+		.retry		= kvm_pgtable_walk_retry,
 		.flags		= flags |
 				  KVM_PGTABLE_WALK_TABLE_PRE |
 				  KVM_PGTABLE_WALK_LEAF,
@@ -989,6 +1011,8 @@ int kvm_pgtable_stage2_set_owner(struct kvm_pgtable *pgt, u64 addr, u64 size,
 	};
 	struct kvm_pgtable_walker walker = {
 		.cb		= stage2_map_walker,
+		.ignore		= kvm_pgtable_walk_continue,
+		.retry		= kvm_pgtable_walk_retry,
 		.flags		= KVM_PGTABLE_WALK_TABLE_PRE |
 				  KVM_PGTABLE_WALK_LEAF,
 		.arg		= &map_data,
@@ -1048,6 +1072,8 @@ int kvm_pgtable_stage2_unmap(struct kvm_pgtable *pgt, u64 addr, u64 size)
 {
 	struct kvm_pgtable_walker walker = {
 		.cb	= stage2_unmap_walker,
+		.ignore	= kvm_pgtable_walk_continue,
+		.retry	= kvm_pgtable_walk_retry,
 		.arg	= pgt,
 		.flags	= KVM_PGTABLE_WALK_LEAF | KVM_PGTABLE_WALK_TABLE_POST,
 	};
@@ -1070,7 +1096,7 @@ static int stage2_attr_walker(const struct kvm_pgtable_visit_ctx *ctx,
 	struct kvm_pgtable_mm_ops *mm_ops = ctx->mm_ops;
 
 	if (!kvm_pte_valid(ctx->old))
-		return -EAGAIN;
+		return -ENOENT;
 
 	data->level = ctx->level;
 	data->pte = pte;
@@ -1099,6 +1125,23 @@ static int stage2_attr_walker(const struct kvm_pgtable_visit_ctx *ctx,
 	return 0;
 }
 
+static bool stage2_attr_walker_retry(const struct kvm_pgtable_walker *walker, int ret)
+{
+	if (ret == -EAGAIN)
+		return walker->flags & KVM_PGTABLE_WALK_SHARED
+				&& !(walker->flags & KVM_PGTABLE_WALK_HANDLE_FAULT);
+	return false;
+}
+
+static bool stage2_attr_walker_ignore(const struct kvm_pgtable_walker * walker, int ret)
+{
+	if (ret == -EAGAIN)
+		return !(walker->flags & KVM_PGTABLE_WALK_SHARED);
+	if (ret == -ENOENT)
+		return !(walker->flags & KVM_PGTABLE_WALK_HANDLE_FAULT);
+	return false;
+}
+
 static int stage2_update_leaf_attrs(struct kvm_pgtable *pgt, u64 addr,
 				    u64 size, kvm_pte_t attr_set,
 				    kvm_pte_t attr_clr, kvm_pte_t *orig_pte,
@@ -1112,6 +1155,8 @@ static int stage2_update_leaf_attrs(struct kvm_pgtable *pgt, u64 addr,
 	};
 	struct kvm_pgtable_walker walker = {
 		.cb		= stage2_attr_walker,
+		.ignore		= stage2_attr_walker_ignore,
+		.retry		= stage2_attr_walker_retry,
 		.arg		= &data,
 		.flags		= flags | KVM_PGTABLE_WALK_LEAF,
 	};
@@ -1217,6 +1262,8 @@ int kvm_pgtable_stage2_flush(struct kvm_pgtable *pgt, u64 addr, u64 size)
 {
 	struct kvm_pgtable_walker walker = {
 		.cb	= stage2_flush_walker,
+		.ignore	= kvm_pgtable_walk_continue,
+		.retry	= kvm_pgtable_walk_retry,
 		.flags	= KVM_PGTABLE_WALK_LEAF,
 		.arg	= pgt,
 	};
@@ -1240,6 +1287,8 @@ kvm_pte_t *kvm_pgtable_stage2_create_unlinked(struct kvm_pgtable *pgt,
 	};
 	struct kvm_pgtable_walker walker = {
 		.cb		= stage2_map_walker,
+		.ignore		= kvm_pgtable_walk_continue,
+		.retry		= kvm_pgtable_walk_retry,
 		.flags		= KVM_PGTABLE_WALK_LEAF |
 				  KVM_PGTABLE_WALK_SKIP_BBM_TLBI |
 				  KVM_PGTABLE_WALK_SKIP_CMO,
@@ -1377,6 +1426,8 @@ int kvm_pgtable_stage2_split(struct kvm_pgtable *pgt, u64 addr, u64 size,
 {
 	struct kvm_pgtable_walker walker = {
 		.cb	= stage2_split_walker,
+		.ignore	= kvm_pgtable_walk_continue,
+		.retry	= kvm_pgtable_walk_retry,
 		.flags	= KVM_PGTABLE_WALK_LEAF,
 		.arg	= mc,
 	};
@@ -1442,6 +1493,8 @@ void kvm_pgtable_stage2_destroy(struct kvm_pgtable *pgt)
 	size_t pgd_sz;
 	struct kvm_pgtable_walker walker = {
 		.cb	= stage2_free_walker,
+		.ignore	= kvm_pgtable_walk_continue,
+		.retry	= kvm_pgtable_walk_retry,
 		.flags	= KVM_PGTABLE_WALK_LEAF |
 			  KVM_PGTABLE_WALK_TABLE_POST,
 	};
@@ -1457,6 +1510,8 @@ void kvm_pgtable_stage2_free_unlinked(struct kvm_pgtable_mm_ops *mm_ops, void *p
 	kvm_pteref_t ptep = (kvm_pteref_t)pgtable;
 	struct kvm_pgtable_walker walker = {
 		.cb	= stage2_free_walker,
+		.ignore	= kvm_pgtable_walk_continue,
+		.retry	= kvm_pgtable_walk_retry,
 		.flags	= KVM_PGTABLE_WALK_LEAF |
 			  KVM_PGTABLE_WALK_TABLE_POST,
 	};
