Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902886D8C0E
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 02:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbjDFAkz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Apr 2023 20:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbjDFAkw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Apr 2023 20:40:52 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCDF7AAD
        for <linux-kselftest@vger.kernel.org>; Wed,  5 Apr 2023 17:40:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x15-20020a25accf000000b00b3b4535c48dso37135766ybd.7
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Apr 2023 17:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680741642;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=86LHwDxbqMA7EgIyrHSvlY9AORL1guRyVq9NFPa+Olo=;
        b=HcRhM6sTP5PyaR4Zf1Q7FlF0bU9gstMdD7EfFj/Cm85riZ8dzdICA0NjEyFL8CR3AF
         hxXzT18Geg4FzvAHbf52BOOBjzChIlxDW9GTl4e3Ks7ITBh3I4CLt94Qd+GYr7WJFVkL
         uLN5DDUUheZZWSMqpM9KmNQ2RwGIYlfKqNhwF8DXtGD+BoCdN2vOVeW7b1q60AKHT90Z
         m6o2IwE0ZmekKuHzDTPbGQ9rMJ6n2O+R2UWKmgZFt9K/xWvI1kOccL0znJUrgofp0Zzk
         g+fhPPL2w6pEtiAw7635Ikh3FxyVN42WMjKyn9ciFC77arT4NPoZLXSK1u0j7ssClDVO
         8XIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680741642;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=86LHwDxbqMA7EgIyrHSvlY9AORL1guRyVq9NFPa+Olo=;
        b=SvfbP8syfopzqtTYBte0fSVP/OqJV8H4RT5k3AxjSE9TY9+HQ8hzgn4s0eB1R/DG6g
         3B5cxeGaDSVsG0XNttbQ7AlpB8rSRqTxziUSMrS8vvk2d/cFBZO4B0zVfgiVvEB5BkXS
         7YkZPwUfkzii56BL71bfoxC7Evrp0xdbqyTJsCd0NKWL+dBaKbRDUY1k5A4lq6jYWY9s
         okWiSXTIah7wzvXGuKyfbq3J4aJxSbTEiSyw+gll3JYypIIH0/+dY24DP+7dRBrAz/js
         Y+zxAUfLO1rHGUMckbqlMQx+zZmuuR9ggxWUr5++UjT3GS61uGjJ1dQ0UDDLwFgLLs+t
         D8Hg==
X-Gm-Message-State: AAQBX9fadQWd2J4K/5yiRLLxM9kFb4hUrTCzprBhjBhovnb4DuGXJ6ai
        1uwngeH1r/th8+JiORQK9vzztUA3f7o=
X-Google-Smtp-Source: AKy350YAt6ZMsFFTOWu2ksg2/ZTfTAJGzlC/5DCbZrqUaZaNaXr7iorKEQpD8rPmaj8Ld3OWCjKLuhYHjWY=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:694f:f21b:c6de:aead])
 (user=drosen job=sendgmr) by 2002:a81:a94a:0:b0:545:6132:e75f with SMTP id
 g71-20020a81a94a000000b005456132e75fmr4752651ywh.8.1680741642553; Wed, 05 Apr
 2023 17:40:42 -0700 (PDT)
Date:   Wed,  5 Apr 2023 17:40:17 -0700
In-Reply-To: <20230406004018.1439952-1-drosen@google.com>
Mime-Version: 1.0
References: <20230406004018.1439952-1-drosen@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230406004018.1439952-3-drosen@google.com>
Subject: [PATCH 2/3] bpf: Allow NULL buffers in bpf_dynptr_slice(_rw)
From:   Daniel Rosenberg <drosen@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

bpf_dynptr_slice(_rw) uses a user provided buffer if it can not provide
a pointer to a block of contiguous memory. This buffer is unused in the
case of local dynptrs, and may be unused in other cases as well. There
is no need to require the buffer, as the kfunc can just return NULL if
it was needed and not provided.

This adds another kfunc annotation, __opt, which combines with __sz and
__szk to allow the buffer associated with the size to be NULL. If the
buffer is NULL, the verifier does not check that the buffer is of
sufficient size.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 Documentation/bpf/kfuncs.rst | 23 ++++++++++++++++++++++-
 kernel/bpf/helpers.c         | 32 ++++++++++++++++++++------------
 kernel/bpf/verifier.c        | 17 +++++++++++++++++
 3 files changed, 59 insertions(+), 13 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index d8a16c4bef7f..69573b511233 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -100,7 +100,7 @@ Hence, whenever a constant scalar argument is accepted by a kfunc which is not a
 size parameter, and the value of the constant matters for program safety, __k
 suffix should be used.
 
-2.2.2 __uninit Annotation
+2.2.3 __uninit Annotation
 -------------------------
 
 This annotation is used to indicate that the argument will be treated as
@@ -117,6 +117,27 @@ Here, the dynptr will be treated as an uninitialized dynptr. Without this
 annotation, the verifier will reject the program if the dynptr passed in is
 not initialized.
 
+2.2.4 __opt Annotation
+-------------------------
+
+This annotation is used to indicate that the buffer associated with an __sz or __szk
+argument may be null. If the function is passed a nullptr in place of the buffer,
+the verifier will not check that length is appropriate for the buffer. The kfunc is
+responsible for checking if this buffer is null before using it.
+
+An example is given below::
+
+        __bpf_kfunc void *bpf_dynptr_slice(..., void *buffer__opt, u32 buffer__szk)
+        {
+        ...
+        }
+
+Here, the buffer may be null. If buffer is not null, it at least of size buffer_szk.
+Either way, the returned buffer is either NULL, or of size buffer_szk. Without this
+annotation, the verifier will reject the program if a null pointer is passed in with
+a nonzero size.
+
+
 .. _BPF_kfunc_nodef:
 
 2.3 Using an existing kernel function
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6be16db9f188..f08556fd8b96 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2145,13 +2145,15 @@ __bpf_kfunc struct task_struct *bpf_task_from_pid(s32 pid)
  * bpf_dynptr_slice() - Obtain a read-only pointer to the dynptr data.
  * @ptr: The dynptr whose data slice to retrieve
  * @offset: Offset into the dynptr
- * @buffer: User-provided buffer to copy contents into
- * @buffer__szk: Size (in bytes) of the buffer. This is the length of the
- *		 requested slice. This must be a constant.
+ * @buffer__opt: User-provided buffer to copy contents into.  May be NULL
+ * @buffer__szk: Size (in bytes) of the buffer if present. This is the
+ *               length of the requested slice. This must be a constant.
  *
  * For non-skb and non-xdp type dynptrs, there is no difference between
  * bpf_dynptr_slice and bpf_dynptr_data.
  *
+ *  If buffer__opt is NULL, the call will fail if buffer_opt was needed.
+ *
  * If the intention is to write to the data slice, please use
  * bpf_dynptr_slice_rdwr.
  *
@@ -2168,7 +2170,7 @@ __bpf_kfunc struct task_struct *bpf_task_from_pid(s32 pid)
  * direct pointer)
  */
 __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset,
-				   void *buffer, u32 buffer__szk)
+				   void *buffer__opt, u32 buffer__szk)
 {
 	enum bpf_dynptr_type type;
 	u32 len = buffer__szk;
@@ -2188,15 +2190,19 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset
 	case BPF_DYNPTR_TYPE_RINGBUF:
 		return ptr->data + ptr->offset + offset;
 	case BPF_DYNPTR_TYPE_SKB:
-		return skb_header_pointer(ptr->data, ptr->offset + offset, len, buffer);
+		if (!buffer__opt)
+			return NULL;
+		return skb_header_pointer(ptr->data, ptr->offset + offset, len, buffer__opt);
 	case BPF_DYNPTR_TYPE_XDP:
 	{
 		void *xdp_ptr = bpf_xdp_pointer(ptr->data, ptr->offset + offset, len);
 		if (xdp_ptr)
 			return xdp_ptr;
 
-		bpf_xdp_copy_buf(ptr->data, ptr->offset + offset, buffer, len, false);
-		return buffer;
+		if (!buffer__opt)
+			return NULL;
+		bpf_xdp_copy_buf(ptr->data, ptr->offset + offset, buffer__opt, len, false);
+		return buffer__opt;
 	}
 	default:
 		WARN_ONCE(true, "unknown dynptr type %d\n", type);
@@ -2208,13 +2214,15 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset
  * bpf_dynptr_slice_rdwr() - Obtain a writable pointer to the dynptr data.
  * @ptr: The dynptr whose data slice to retrieve
  * @offset: Offset into the dynptr
- * @buffer: User-provided buffer to copy contents into
- * @buffer__szk: Size (in bytes) of the buffer. This is the length of the
- *		 requested slice. This must be a constant.
+ * @buffer__opt: User-provided buffer to copy contents into. May be NULL
+ * @buffer__szk: Size (in bytes) of the buffer if present. This is the
+ *               length of the requested slice. This must be a constant.
  *
  * For non-skb and non-xdp type dynptrs, there is no difference between
  * bpf_dynptr_slice and bpf_dynptr_data.
  *
+ * If buffer__opt is NULL, the call will fail if buffer_opt was needed.
+ *
  * The returned pointer is writable and may point to either directly the dynptr
  * data at the requested offset or to the buffer if unable to obtain a direct
  * data pointer to (example: the requested slice is to the paged area of an skb
@@ -2245,7 +2253,7 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset
  * direct pointer)
  */
 __bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern *ptr, u32 offset,
-					void *buffer, u32 buffer__szk)
+					void *buffer__opt, u32 buffer__szk)
 {
 	if (!ptr->data || bpf_dynptr_is_rdonly(ptr))
 		return NULL;
@@ -2272,7 +2280,7 @@ __bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern *ptr, u32 o
 	 * will be copied out into the buffer and the user will need to call
 	 * bpf_dynptr_write() to commit changes.
 	 */
-	return bpf_dynptr_slice(ptr, offset, buffer, buffer__szk);
+	return bpf_dynptr_slice(ptr, offset, buffer__opt, buffer__szk);
 }
 
 __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 20beab52812a..b82faef389b1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9428,6 +9428,19 @@ static bool is_kfunc_arg_const_mem_size(const struct btf *btf,
 	return __kfunc_param_match_suffix(btf, arg, "__szk");
 }
 
+static bool is_kfunc_arg_optional(const struct btf *btf,
+		  const struct btf_param *arg,
+		  const struct bpf_reg_state *reg)
+{
+	const struct btf_type *t;
+
+	t = btf_type_skip_modifiers(btf, arg->type, NULL);
+	if (!btf_type_is_ptr(t) || reg->type != SCALAR_VALUE || reg->umax_value > 0)
+		return false;
+
+	return __kfunc_param_match_suffix(btf, arg, "__opt");
+}
+
 static bool is_kfunc_arg_constant(const struct btf *btf, const struct btf_param *arg)
 {
 	return __kfunc_param_match_suffix(btf, arg, "__k");
@@ -10539,10 +10552,14 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			break;
 		case KF_ARG_PTR_TO_MEM_SIZE:
 		{
+			struct bpf_reg_state *buff_reg = &regs[regno];
+			const struct btf_param *buff_arg = &args[i];
 			struct bpf_reg_state *size_reg = &regs[regno + 1];
 			const struct btf_param *size_arg = &args[i + 1];
 
 			ret = check_kfunc_mem_size_reg(env, size_reg, regno + 1);
+			if (ret < 0 && is_kfunc_arg_optional(meta->btf, buff_arg, buff_reg))
+				ret = 0;
 			if (ret < 0) {
 				verbose(env, "arg#%d arg#%d memory, len pair leads to invalid memory access\n", i, i + 1);
 				return ret;
-- 
2.40.0.577.gac1e443424-goog

