Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7AE51DB9F
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 May 2022 17:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442742AbiEFPNc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 May 2022 11:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442714AbiEFPNO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 May 2022 11:13:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 506586D1AC
        for <linux-kselftest@vger.kernel.org>; Fri,  6 May 2022 08:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651849769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DK+TUwjVQptS0umRI644AMDR5FekGwK1XVxduELatig=;
        b=JuI/Z+hQ99n8pVT+6p602kpxlK9CPZSohBrkPhE9HvG9A2f40cbAh7kEmeABbx7WkqAHmB
        YUGQVoLLQUq1G+HIqyh4Ucp4Knt/9l+F4gvnWDEgeb2qQJBwn24CzJwqwR4yg91wDN+Xu0
        nlAJOrQlUuc0yZlo4Km76q4DfnVMN44=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-257-petG5evUMCCAOrdmNcnVuw-1; Fri, 06 May 2022 11:09:26 -0400
X-MC-Unique: petG5evUMCCAOrdmNcnVuw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B6E32999B59;
        Fri,  6 May 2022 15:09:25 +0000 (UTC)
Received: from localhost (unknown [10.39.193.152])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 45E3F9E74;
        Fri,  6 May 2022 15:09:25 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Joey Gouly <joey.gouly@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [ARM64] status of MTE selftests?
In-Reply-To: <87wney4svy.fsf@redhat.com>
Organization: Red Hat GmbH
References: <87wney4svy.fsf@redhat.com>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date:   Fri, 06 May 2022 17:09:23 +0200
Message-ID: <87r1564s0s.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[memo to self: don't send stuff on Friday evenings]

Sorry about the spam, resend w/o config, see
https://people.redhat.com/~cohuck/config-mte

On Fri, May 06 2022, Cornelia Huck <cohuck@redhat.com> wrote:

> Hi,
>
> I'm currently trying to run the MTE selftests on the FVP simulator (Base
> Model)[1], mainly to verify things are sane on the host before wiring up
> the KVM support in QEMU. However, I'm seeing some failures (the non-mte
> tests seemed all fine):
>
> # selftests: /arm64: check_buffer_fill
> # 1..20
> # ok 1 Check buffer correctness by byte with sync err mode and mmap memory
> # ok 2 Check buffer correctness by byte with async err mode and mmap memory
> # ok 3 Check buffer correctness by byte with sync err mode and mmap/mprotect memory
> # ok 4 Check buffer correctness by byte with async err mode and mmap/mprotect memory
> # not ok 5 Check buffer write underflow by byte with sync mode and mmap memory
> # not ok 6 Check buffer write underflow by byte with async mode and mmap memory
> # ok 7 Check buffer write underflow by byte with tag check fault ignore and mmap memory
> # not ok 8 Check buffer write underflow by byte with sync mode and mmap memory
> # not ok 9 Check buffer write underflow by byte with async mode and mmap memory
> # ok 10 Check buffer write underflow by byte with tag check fault ignore and mmap memory
> # not ok 11 Check buffer write overflow by byte with sync mode and mmap memory
> # not ok 12 Check buffer write overflow by byte with async mode and mmap memory
> # ok 13 Check buffer write overflow by byte with tag fault ignore mode and mmap memory
> # ok 14 Check buffer write correctness by block with sync mode and mmap memory
> # ok 15 Check buffer write correctness by block with async mode and mmap memory
> # ok 16 Check buffer write correctness by block with tag fault ignore and mmap memory
> # ok 17 Check initial tags with private mapping, sync error mode and mmap memory
> # ok 18 Check initial tags with private mapping, sync error mode and mmap/mprotect memory
> # ok 19 Check initial tags with shared mapping, sync error mode and mmap memory
> # ok 20 Check initial tags with shared mapping, sync error mode and mmap/mprotect memory
> # # Totals: pass:14 fail:6 xfail:0 xpass:0 skip:0 error:0
> not ok 24 selftests: /arm64: check_buffer_fill # exit=1
>
> # selftests: /arm64: check_child_memory
> # 1..12
> # not ok 1 Check child anonymous memory with private mapping, precise mode and mmap memory
> # not ok 2 Check child anonymous memory with shared mapping, precise mode and mmap memory
> # not ok 3 Check child anonymous memory with private mapping, imprecise mode and mmap memory
> # not ok 4 Check child anonymous memory with shared mapping, imprecise mode and mmap memory
> # not ok 5 Check child anonymous memory with private mapping, precise mode and mmap/mprotect memory
> # not ok 6 Check child anonymous memory with shared mapping, precise mode and mmap/mprotect memory
> # not ok 7 Check child file memory with private mapping, precise mode and mmap memory
> # not ok 8 Check child file memory with shared mapping, precise mode and mmap memory
> # not ok 9 Check child file memory with private mapping, imprecise mode and mmap memory
> # not ok 10 Check child file memory with shared mapping, imprecise mode and mmap memory
> # not ok 11 Check child file memory with private mapping, precise mode and mmap/mprotect memory
> # not ok 12 Check child file memory with shared mapping, precise mode and mmap/mprotect memory
> # # Totals: pass:0 fail:12 xfail:0 xpass:0 skip:0 error:0
> not ok 25 selftests: /arm64: check_child_memory # exit=1
>
> # selftests: /arm64: check_gcr_el1_cswitch
> # 1..1
> # 1..1
> # 1..1
> # 1..1
> [...many more lines of the same...]
> # 1..1
> #
> not ok 26 selftests: /arm64: check_gcr_el1_cswitch # TIMEOUT 45 seconds
>
> # selftests: /arm64: check_mmap_options
> # 1..22
> # ok 1 Check anonymous memory with private mapping, sync error mode, mmap memory and tag check off
> # ok 2 Check file memory with private mapping, sync error mode, mmap/mprotect memory and tag check off
> # ok 3 Check anonymous memory with private mapping, no error mode, mmap memory and tag check off
> # ok 4 Check file memory with private mapping, no error mode, mmap/mprotect memory and tag check off
> # not ok 5 Check anonymous memory with private mapping, sync error mode, mmap memory and tag check on
> # not ok 6 Check anonymous memory with private mapping, sync error mode, mmap/mprotect memory and tag check on
> # not ok 7 Check anonymous memory with shared mapping, sync error mode, mmap memory and tag check on
> # not ok 8 Check anonymous memory with shared mapping, sync error mode, mmap/mprotect memory and tag check on
> # not ok 9 Check anonymous memory with private mapping, async error mode, mmap memory and tag check on
> # not ok 10 Check anonymous memory with private mapping, async error mode, mmap/mprotect memory and tag check on
> # not ok 11 Check anonymous memory with shared mapping, async error mode, mmap memory and tag check on
> # not ok 12 Check anonymous memory with shared mapping, async error mode, mmap/mprotect memory and tag check on
> # not ok 13 Check file memory with private mapping, sync error mode, mmap memory and tag check on
> # not ok 14 Check file memory with private mapping, sync error mode, mmap/mprotect memory and tag check on
> # not ok 15 Check file memory with shared mapping, sync error mode, mmap memory and tag check on
> # not ok 16 Check file memory with shared mapping, sync error mode, mmap/mprotect memory and tag check on
> # not ok 17 Check file memory with private mapping, async error mode, mmap memory and tag check on
> # not ok 18 Check file memory with private mapping, async error mode, mmap/mprotect memory and tag check on
> # not ok 19 Check file memory with shared mapping, async error mode, mmap memory and tag check on
> # not ok 20 Check file memory with shared mapping, async error mode, mmap/mprotect memory and tag check on
> # not ok 21 Check clear PROT_MTE flags with private mapping, sync error mode and mmap memory
> # not ok 22 Check clear PROT_MTE flags with private mapping and sync error mode and mmap/mprotect memory
> # # Totals: pass:4 fail:18 xfail:0 xpass:0 skip:0 error:0
> not ok 28 selftests: /arm64: check_mmap_options # exit=1
>
> # selftests: /arm64: check_tags_inclusion
> # 1..4
> # not ok 1 Check an included tag value with sync mode
> # not ok 2 Check different included tags value with sync mode
> # ok 3 Check none included tags value with sync mode
> # not ok 4 Check all included tags value with sync mode
> # # Totals: pass:1 fail:3 xfail:0 xpass:0 skip:0 error:0
> not ok 29 selftests: /arm64: check_tags_inclusion # exit=1
>
> check_ksm_options and check_user_mem work as expected.
>
> Are the MTE tests supposed to work on the FVP model? Something broken in
> my config? Anything I can debug?
>
> [1] Command line:
> "$MODEL" \
> -C cache_state_modelled=0 \
> -C bp.refcounter.non_arch_start_at_default=1 \
> -C bp.secure_memory=false \
> -C cluster0.has_arm_v8-1=1 \
> -C cluster0.has_arm_v8-2=1 \
> -C cluster0.has_arm_v8-3=1 \
> -C cluster0.has_arm_v8-4=1 \
> -C cluster0.has_arm_v8-5=1 \
> -C cluster0.has_amu=1 \
> -C cluster0.NUM_CORES=4 \
> -C cluster0.memory_tagging_support_level=2 \
> -a "cluster0.*=$AXF" \
>
> where $AXF contains a kernel at v5.18-rc5-16-g107c948d1d3e[2] and an
> initrd built by mbuto[3] from that level with a slightly tweaked "kselftests"
> profile (adding /dev/shm).
>
> [2] CONFIG_ARM64_MTE=y, no modules; complete config below[4]
>
> [3] https://mbuto.sh/mbuto/
>
> [4] kernel config: https://people.redhat.com/~cohuck/config-mte

