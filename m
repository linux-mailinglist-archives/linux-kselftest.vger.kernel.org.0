Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774B061FCF2
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 19:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbiKGSLZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 13:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbiKGSLL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 13:11:11 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD22C24F07;
        Mon,  7 Nov 2022 10:09:04 -0800 (PST)
Message-ID: <8560651c-d234-65d0-557d-523d05a45c9b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1667844543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OnF5xuDzFDJ3bpeOgOJa6cRnrDV3A/yeW5ykwiRN5vQ=;
        b=ujDV9g7xjfuGR+nlyfySaonfDWCIQY4hMwc//duDBR0y+iD1WeTn6dseuDbZfnazA8zH9U
        1Y4VdMB/0Swxn2U+IkhjbNE1GqeAQ++VbPIaxMH7ofBYDm9j3t+QnS823JHxMeJxgFa3GC
        xsPiR5fhOXpFfAjHXOwQaWdTHFKZZ1E=
Date:   Mon, 7 Nov 2022 10:08:55 -0800
MIME-Version: 1.0
Subject: Re: [net] seg6: selftests/bpf: fix BPF object file name in
 test_lwt_seg6local.sh
Content-Language: en-US
To:     Andrea Mayer <andrea.mayer@uniroma2.it>
Cc:     Stefano Salsano <stefano.salsano@uniroma2.it>,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
        Ahmed Abdelsalam <ahabdels.dev@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        =?UTF-8?Q?Daniel_M=c3=bcller?= <deso@posteo.net>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
References: <20221107143044.27763-1-andrea.mayer@uniroma2.it>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20221107143044.27763-1-andrea.mayer@uniroma2.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/7/22 6:30 AM, Andrea Mayer wrote:
> The test_lwt_seg6local.c implements several eBPF programs which are
> used to test the SRv6 End.BPF behavior.
> Since commit afef88e65554 ("selftests/bpf: Store BPF object files with
> .bpf.o extension"), part of the build system and test programs loading
> BPF object files are supposed to work with the .bpf.o extension.
> 
> Consequently, the test_lwt_seg6local.c is compiled into
> test_lwt_seg6local.bpf.o and the corresponding test_lwt_seg6local.sh
> script is not updated to deal with the correct .bpf.o extension.
> 
> This patch fixes the test_lwt_seg6local.sh, using the correct .bpf.o
> extension for the testing BPF object file, i.e. test_lwt_seg6local.bpf.o.

This has already been fixed in
commit 98af3746026c ("selftests/bpf: fix missing BPF object files") in bpf-next.

