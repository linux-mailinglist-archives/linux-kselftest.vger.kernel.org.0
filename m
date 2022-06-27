Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9469055B526
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jun 2022 04:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiF0COu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 26 Jun 2022 22:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiF0COt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 26 Jun 2022 22:14:49 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CD7270C;
        Sun, 26 Jun 2022 19:14:48 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id x20so1296753plx.6;
        Sun, 26 Jun 2022 19:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p/CeoCTDhGdykZrVT9uCTA5wI+N8E9qPFrIhbM1twyQ=;
        b=kCCTfCQ1mvklpJXP7NiWhdLXjBOOxYtl795VwPhnA7hgO4lUAw/aHLjRHCxxJU2inN
         1OcURComNU+XF/Tkggxo6flVJIqrTG+zra0iiaSR3uHLjtZZ6+UKQ/99ltW09+dOMK9g
         CAygQ7kVIoLkJiW4TlO9S9V8e2++18JTOw3n1vjgmw0Dtq7MfcDKb9aUWnpMQ/xM/HiH
         mn76tQAjg+7gqxs4th0nZcjweZT/yX0ZONmuQAGaIPHTKe5XpptcXd9nJKwYIRyFuZsV
         Edru6wXyWDmvzuuKVpGCyK9Mu5VsN3hH0p92ViJKRsQkoWqpLWA8BSJkitMCcF8nCJXO
         vEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p/CeoCTDhGdykZrVT9uCTA5wI+N8E9qPFrIhbM1twyQ=;
        b=v9MjBJlbkyi/DJQFmTp05jAXp4+J2+j8NmXinpN10vRBRHeDDYUkT5GrQusG0me7+j
         As2CjWWH4+x8srO/Ve6N5ZdbHNVWLuH/yVHRCGkMLdIwLVT+Bjgawy682ZYgYCo8WhRn
         dteNM3C4i9cpPwWJR/nn9j2Rt0Ru99vlYcESXRc2JU0KNh9udCuy5rKhfCCMT7DmujDw
         hI4KIgfwC1ZQJVAnTvgwLsfDwGYZj+vByDjAgPfblR+7uAmVG2c+9DujcBOw9EBiQly9
         DOWoqyt7JYOU1yznzdQYD1g6U48nF38IybMqP15B5QM9SSKC7InijVyWqfVChqK0AJBS
         J//A==
X-Gm-Message-State: AJIora/ypcsbcnpzDT9jsbpWE7rJRIh+3t/OuWkEXZB7LKbEfr7c1yzf
        rGYRiN/gcyLkIOZL/e8/DQiZdocN2Do=
X-Google-Smtp-Source: AGRyM1tdkHDaq/xuwGyhiD4/4kUWaQf4E1SbbajDWVNwklhip7Sx0UNqhvitVWgBy/g5BhWrspL3VQ==
X-Received: by 2002:a17:902:aa8a:b0:16a:1ea5:d417 with SMTP id d10-20020a170902aa8a00b0016a1ea5d417mr12271446plr.4.1656296087523;
        Sun, 26 Jun 2022 19:14:47 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-21.three.co.id. [180.214.233.21])
        by smtp.gmail.com with ESMTPSA id y27-20020a634b1b000000b0040cff9def93sm5749291pga.66.2022.06.26.19.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 19:14:46 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 6F8481038C5; Mon, 27 Jun 2022 09:14:42 +0700 (WIB)
Date:   Mon, 27 Jun 2022 09:14:42 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com, mhiramat@kernel.org,
        zanussi@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        linux-doc@vger.kernel.org, corbet@lwn.net, chensong_2000@189.cn
Subject: Re: [PATCH v13 4/4] Documentation: trace/objtrace: Add documentation
 for objtrace
Message-ID: <YrkSkuluNhGcMyOu@debian.me>
References: <20220626025604.277413-1-xiehuan09@gmail.com>
 <20220626025604.277413-5-xiehuan09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220626025604.277413-5-xiehuan09@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jun 26, 2022 at 10:56:04AM +0800, Jeff Xie wrote:
> Added documentation explaining how to use objtrace trigger to get the value
> of the object.
> 

Write "Add documentation..." instead.

> +- objtrace
> +
> +  This command provides a way to get the value of any object, The object
> +  can be obtained from the dynamic event(kprobe_event/uprobe_event) or the
> +  static event(tracepoint).
> +
> +  Usage:
> +  When using the kprobe event, only need to set the objtrace(a new trigger),
> +  we can get the value of the object. The object is from the setting of the
> +  kprobe event.
> +

Did you mean "the object value can be obtained by only needing to set the
objtrace?"

> +  For example:
> +  For the function bio_add_page():
> +
> +  int bio_add_page(struct bio *bio, struct page *page,
> +	unsigned int len, unsigned int offset)
> +
> +  Firstly, we can set the base of the object, thus the first string "arg1"
> +  stands for the value of the first parameter of this function bio_add_gage(),
> +
> +  # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
> +

Did you mean "the first parameter (arg1) is the parameter value of function
that is passed to kprobe_event, in this case the object base"?

> +  Secondly, we can get the value dynamically based on above object.
> +
> +  find the offset of the bi_size in struct bio:
> +  $ gdb vmlinux
> +  (gdb) p &(((struct bio *)0)->bi_iter.bi_size)
> +  $1 = (unsigned int *) 0x28
> +
> +  # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/ \
> +	p_bio_add_page_0/trigger
> +
> +  # cd /sys/kernel/debug/tracing/
> +  # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
> +  # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/p_bio_add_page_0/trigger
> +
> +  # du -sh /test.txt
> +  12.0K   /test.txt
> +
> +  # cat  /test.txt > /dev/null
> +  # cat ./trace
> +  # tracer: nop
> +  #
> +  # entries-in-buffer/entries-written: 128/128   #P:4
> +  #
> +  #                                _-----=> irqs-off/BH-disabled
> +  #                               / _----=> need-resched
> +  #                              | / _---=> hardirq/softirq
> +  #                              || / _--=> preempt-depth
> +  #                              ||| / _-=> migrate-disable
> +  #                              |||| /     delay
> +  #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> +  #              | |         |   |||||     |         |
> +               cat-117     [002] ...1.     1.602243: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x0
> +               cat-117     [002] ...1.     1.602244: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x0
> +               cat-117     [002] ...2.     1.602244: bio_add_page <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x1000
> +               cat-117     [002] ...1.     1.602245: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x1000
> +               cat-117     [002] ...1.     1.602245: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x1000
> +               cat-117     [002] ...2.     1.602245: bio_add_page <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x2000
> +               cat-117     [002] ...1.     1.602245: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x2000
> +               cat-117     [002] ...1.     1.602245: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x2000
> +               cat-117     [002] ...1.     1.602245: submit_bio <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x3000
> +               cat-117     [002] ...1.     1.602245: submit_bio_noacct <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x3000
> +               cat-117     [002] ...1.     1.602246: __submit_bio <-submit_bio_noacct object:0xffff88811bee4000 value:0x3000
> +               cat-117     [002] ...1.     1.602246: submit_bio_checks <-__submit_bio object:0xffff88811bee4000 value:0x3000
> +               cat-117     [002] ...1.     1.602246: __cond_resched <-submit_bio_checks object:0xffff88811bee4000 value:0x3000
> +               cat-117     [002] ...1.     1.602246: should_fail_bio <-submit_bio_checks object:0xffff88811bee4000 value:0x3000
> +               cat-117     [002] ...1.     1.602246: blk_mq_submit_bio <-submit_bio_noacct object:0xffff88811bee4000 value:0x3000
> +               cat-117     [002] ...1.     1.602246: blk_attempt_plug_merge <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> +               cat-117     [002] ...1.     1.602246: blk_mq_sched_bio_merge <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> +               cat-117     [002] ...1.     1.602247: __rcu_read_lock <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> +               cat-117     [002] ...1.     1.602247: __rcu_read_unlock <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> +               cat-117     [002] ...1.     1.602247: __blk_mq_alloc_requests <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> +            <idle>-0       [002] d..3.     1.602298: bio_endio <-blk_update_request object:0xffff88811bee4000 value:0x0
> +            <idle>-0       [002] d..3.     1.602298: mpage_end_io <-blk_update_request object:0xffff88811bee4000 value:0x0
> +            <idle>-0       [002] d..3.     1.602298: __read_end_io <-blk_update_request object:0xffff88811bee4000 value:0x0
> +            <idle>-0       [002] d..3.     1.602300: bio_put <-blk_update_request object:0xffff88811bee4000 value:0x0
> +            <idle>-0       [002] d..3.     1.602300: bio_free <-blk_update_request object:0xffff88811bee4000 value:0x0
> +            <idle>-0       [002] d..3.     1.602300: mempool_free <-blk_update_request object:0xffff88811bee4000 value:0x0
> +            <idle>-0       [002] d..3.     1.602300: mempool_free_slab <-blk_update_request object:0xffff88811bee4000 value:0x0
> +            <idle>-0       [002] d..3.     1.602300: kmem_cache_free <-blk_update_request object:0xffff88811bee4000 value:0x0
> +             ...
> +

The output is messy, because for code example and output, literal code
blocks aren't used, hence trigger new warnings:

Documentation/trace/events.rst:564: WARNING: Inline emphasis start-string without end-string.
Documentation/trace/events.rst:564: WARNING: Inline emphasis start-string without end-string.
Documentation/trace/events.rst:573: WARNING: Inline emphasis start-string without end-string.
Documentation/trace/events.rst:573: WARNING: Inline emphasis start-string without end-string.
Documentation/trace/events.rst:602: WARNING: Unexpected indentation.
Documentation/trace/events.rst:622: WARNING: Block quote ends without a blank line; unexpected unindent.
Documentation/trace/events.rst:630: WARNING: Unexpected indentation.

I had to apply the following fixup (with rewording):

---- >8 ----

diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index 0dc47516013331..c15f1d25d4a071 100644
--- a/Documentation/trace/events.rst
+++ b/Documentation/trace/events.rst
@@ -549,85 +549,89 @@ The following commands are supported:
 - objtrace
 
   This command provides a way to get the value of any object, The object
-  can be obtained from the dynamic event(kprobe_event/uprobe_event) or the
-  static event(tracepoint).
+  can be obtained from the dynamic event (kprobe_event/uprobe_event) or the
+  static event (tracepoint).
 
   Usage:
-  When using the kprobe event, only need to set the objtrace(a new trigger),
-  we can get the value of the object. The object is from the setting of the
-  kprobe event.
+  When using the kprobe event, by only need to set the objtrace (a new
+  trigger), we can get the value of object that is set by kprobe event.
 
-  For example:
-  For the function bio_add_page():
+  For example, for the function bio_add_page():
 
-  int bio_add_page(struct bio *bio, struct page *page,
-	unsigned int len, unsigned int offset)
+  .. code-block:: c
 
-  Firstly, we can set the base of the object, thus the first string "arg1"
-  stands for the value of the first parameter of this function bio_add_gage(),
+     int bio_add_page(struct bio *bio, struct page *page,
+	              unsigned int len, unsigned int offset)
 
-  # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
+  Firstly, we can set the base of the object as first parameter (arg1) to
+  to the function:
 
-  Secondly, we can get the value dynamically based on above object.
+  .. code-block::
 
-  find the offset of the bi_size in struct bio:
-  $ gdb vmlinux
-  (gdb) p &(((struct bio *)0)->bi_iter.bi_size)
-  $1 = (unsigned int *) 0x28
+     # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
 
-  # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/ \
-	p_bio_add_page_0/trigger
+  Secondly, we can get the value dynamically based on the object:
 
-  # cd /sys/kernel/debug/tracing/
-  # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
-  # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/p_bio_add_page_0/trigger
+  .. code-block::
 
-  # du -sh /test.txt
-  12.0K   /test.txt
+     find the offset of the bi_size in struct bio:
+     $ gdb vmlinux
+     (gdb) p &(((struct bio *)0)->bi_iter.bi_size)
+     $1 = (unsigned int *) 0x28
 
-  # cat  /test.txt > /dev/null
-  # cat ./trace
-  # tracer: nop
-  #
-  # entries-in-buffer/entries-written: 128/128   #P:4
-  #
-  #                                _-----=> irqs-off/BH-disabled
-  #                               / _----=> need-resched
-  #                              | / _---=> hardirq/softirq
-  #                              || / _--=> preempt-depth
-  #                              ||| / _-=> migrate-disable
-  #                              |||| /     delay
-  #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
-  #              | |         |   |||||     |         |
-               cat-117     [002] ...1.     1.602243: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x0
-               cat-117     [002] ...1.     1.602244: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x0
-               cat-117     [002] ...2.     1.602244: bio_add_page <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x1000
-               cat-117     [002] ...1.     1.602245: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x1000
-               cat-117     [002] ...1.     1.602245: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x1000
-               cat-117     [002] ...2.     1.602245: bio_add_page <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x2000
-               cat-117     [002] ...1.     1.602245: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x2000
-               cat-117     [002] ...1.     1.602245: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x2000
-               cat-117     [002] ...1.     1.602245: submit_bio <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x3000
-               cat-117     [002] ...1.     1.602245: submit_bio_noacct <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x3000
-               cat-117     [002] ...1.     1.602246: __submit_bio <-submit_bio_noacct object:0xffff88811bee4000 value:0x3000
-               cat-117     [002] ...1.     1.602246: submit_bio_checks <-__submit_bio object:0xffff88811bee4000 value:0x3000
-               cat-117     [002] ...1.     1.602246: __cond_resched <-submit_bio_checks object:0xffff88811bee4000 value:0x3000
-               cat-117     [002] ...1.     1.602246: should_fail_bio <-submit_bio_checks object:0xffff88811bee4000 value:0x3000
-               cat-117     [002] ...1.     1.602246: blk_mq_submit_bio <-submit_bio_noacct object:0xffff88811bee4000 value:0x3000
-               cat-117     [002] ...1.     1.602246: blk_attempt_plug_merge <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
-               cat-117     [002] ...1.     1.602246: blk_mq_sched_bio_merge <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
-               cat-117     [002] ...1.     1.602247: __rcu_read_lock <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
-               cat-117     [002] ...1.     1.602247: __rcu_read_unlock <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
-               cat-117     [002] ...1.     1.602247: __blk_mq_alloc_requests <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
-            <idle>-0       [002] d..3.     1.602298: bio_endio <-blk_update_request object:0xffff88811bee4000 value:0x0
-            <idle>-0       [002] d..3.     1.602298: mpage_end_io <-blk_update_request object:0xffff88811bee4000 value:0x0
-            <idle>-0       [002] d..3.     1.602298: __read_end_io <-blk_update_request object:0xffff88811bee4000 value:0x0
-            <idle>-0       [002] d..3.     1.602300: bio_put <-blk_update_request object:0xffff88811bee4000 value:0x0
-            <idle>-0       [002] d..3.     1.602300: bio_free <-blk_update_request object:0xffff88811bee4000 value:0x0
-            <idle>-0       [002] d..3.     1.602300: mempool_free <-blk_update_request object:0xffff88811bee4000 value:0x0
-            <idle>-0       [002] d..3.     1.602300: mempool_free_slab <-blk_update_request object:0xffff88811bee4000 value:0x0
-            <idle>-0       [002] d..3.     1.602300: kmem_cache_free <-blk_update_request object:0xffff88811bee4000 value:0x0
-             ...
+     # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/ \
+       p_bio_add_page_0/trigger
+
+     # cd /sys/kernel/debug/tracing/
+     # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
+     # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/p_bio_add_page_0/trigger
+
+     # du -sh /test.txt
+     12.0K   /test.txt
+
+     # cat  /test.txt > /dev/null
+     # cat ./trace
+     # tracer: nop
+     #
+     # entries-in-buffer/entries-written: 128/128   #P:4
+     #
+     #                                _-----=> irqs-off/BH-disabled
+     #                               / _----=> need-resched
+     #                              | / _---=> hardirq/softirq
+     #                              || / _--=> preempt-depth
+     #                              ||| / _-=> migrate-disable
+     #                              |||| /     delay
+     #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
+     #              | |         |   |||||     |         |
+                  cat-117     [002] ...1.     1.602243: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x0
+                  cat-117     [002] ...1.     1.602244: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x0
+                  cat-117     [002] ...2.     1.602244: bio_add_page <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x1000
+                  cat-117     [002] ...1.     1.602245: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x1000
+                  cat-117     [002] ...1.     1.602245: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x1000
+                  cat-117     [002] ...2.     1.602245: bio_add_page <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x2000
+                  cat-117     [002] ...1.     1.602245: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x2000
+                  cat-117     [002] ...1.     1.602245: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x2000
+                  cat-117     [002] ...1.     1.602245: submit_bio <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x3000
+                  cat-117     [002] ...1.     1.602245: submit_bio_noacct <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x3000
+                  cat-117     [002] ...1.     1.602246: __submit_bio <-submit_bio_noacct object:0xffff88811bee4000 value:0x3000
+                  cat-117     [002] ...1.     1.602246: submit_bio_checks <-__submit_bio object:0xffff88811bee4000 value:0x3000
+                  cat-117     [002] ...1.     1.602246: __cond_resched <-submit_bio_checks object:0xffff88811bee4000 value:0x3000
+                  cat-117     [002] ...1.     1.602246: should_fail_bio <-submit_bio_checks object:0xffff88811bee4000 value:0x3000
+                  cat-117     [002] ...1.     1.602246: blk_mq_submit_bio <-submit_bio_noacct object:0xffff88811bee4000 value:0x3000
+                  cat-117     [002] ...1.     1.602246: blk_attempt_plug_merge <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
+                  cat-117     [002] ...1.     1.602246: blk_mq_sched_bio_merge <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
+                  cat-117     [002] ...1.     1.602247: __rcu_read_lock <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
+                  cat-117     [002] ...1.     1.602247: __rcu_read_unlock <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
+                  cat-117     [002] ...1.     1.602247: __blk_mq_alloc_requests <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
+               <idle>-0       [002] d..3.     1.602298: bio_endio <-blk_update_request object:0xffff88811bee4000 value:0x0
+               <idle>-0       [002] d..3.     1.602298: mpage_end_io <-blk_update_request object:0xffff88811bee4000 value:0x0
+               <idle>-0       [002] d..3.     1.602298: __read_end_io <-blk_update_request object:0xffff88811bee4000 value:0x0
+               <idle>-0       [002] d..3.     1.602300: bio_put <-blk_update_request object:0xffff88811bee4000 value:0x0
+               <idle>-0       [002] d..3.     1.602300: bio_free <-blk_update_request object:0xffff88811bee4000 value:0x0
+               <idle>-0       [002] d..3.     1.602300: mempool_free <-blk_update_request object:0xffff88811bee4000 value:0x0
+               <idle>-0       [002] d..3.     1.602300: mempool_free_slab <-blk_update_request object:0xffff88811bee4000 value:0x0
+               <idle>-0       [002] d..3.     1.602300: kmem_cache_free <-blk_update_request object:0xffff88811bee4000 value:0x0
+                ...
 
 7. In-kernel trace event API
 ============================


Thanks.

-- 
An old man doll... just what I always wanted! - Clara
