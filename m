Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB62770651
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 18:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjHDQvN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 12:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjHDQvM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 12:51:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669921994;
        Fri,  4 Aug 2023 09:51:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04F496209F;
        Fri,  4 Aug 2023 16:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54267C433C7;
        Fri,  4 Aug 2023 16:51:09 +0000 (UTC)
Date:   Fri, 4 Aug 2023 12:51:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Zheng Yejian <zhengyejian1@huawei.com>, mhiramat@kernel.org,
        vnagarnaik@google.com, shuah@kernel.org, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: Fix cpu buffers unavailable due to
 'record_disabled' messed
Message-ID: <20230804125107.41d6cdb1@gandalf.local.home>
In-Reply-To: <202308050048.bUnVeBjV-lkp@intel.com>
References: <20230804124549.2562977-2-zhengyejian1@huawei.com>
        <202308050048.bUnVeBjV-lkp@intel.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, 5 Aug 2023 00:41:13 +0800
kernel test robot <lkp@intel.com> wrote:

>   5276			if (cpumask_test_cpu(cpu, tr->tracing_cpumask) &&
>   5277					!cpumask_test_cpu(cpu, tracing_cpumask_new)) {
>   5278				atomic_inc(&per_cpu_ptr(tr->array_buffer.data, cpu)->disabled);
>   5279				ring_buffer_record_disable_cpu(tr->array_buffer.buffer, cpu);
> > 5280				ring_buffer_record_disable_cpu(tr->max_buffer.buffer, cpu);  

The access to max_buffer requires a:

#ifdef CONFIG_TRACER_MAX_TRACE

Around them.

-- Steve

>   5281			}
>   5282			if (!cpumask_test_cpu(cpu, tr->tracing_cpumask) &&
>   5283					cpumask_test_cpu(cpu, tracing_cpumask_new)) {
>   5284				atomic_dec(&per_cpu_ptr(tr->array_buffer.data, cpu)->disabled);
>   5285				ring_buffer_record_enable_cpu(tr->array_buffer.buffer, cpu);
>   5286				ring_buffer_record_enable_cpu(tr->max_buffer.buffer, cpu);
>   5287			}
>   5288		}
>   5289		arch_spin_unlock(&tr->max_lock);
