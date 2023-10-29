Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9417DAD6A
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Oct 2023 18:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjJ2RHy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 29 Oct 2023 13:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjJ2RHx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 29 Oct 2023 13:07:53 -0400
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [IPv6:2001:41d0:203:375::b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F362C6
        for <linux-kselftest@vger.kernel.org>; Sun, 29 Oct 2023 10:07:51 -0700 (PDT)
Message-ID: <1b463b8a-eac0-4894-b265-da1d3e51c674@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698599269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CwjmesJBPd77RraX0VXEJ5fpmp3TmiDHUFN/EhxgGxI=;
        b=XQbDmpBOLN53bjspOhw7G4X/xCSZRhmYT6bEkgzQPOdJunYr9MryJGIPcEh+IqVd7xcMBO
        yQDcR7W+7lzew3Fqf6oH1O8YsfSoVeHubyMyd8WtA58cBWSly5DedTyPSSpnnhx4LiaCCZ
        wuToRNnwdmOb4VSSDe+mmdFeStEb5JI=
Date:   Sun, 29 Oct 2023 10:07:44 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Add malloc failure checks
 in bpf_iter
Content-Language: en-GB
To:     Yuran Pereira <yuran.pereira@hotmail.com>, bpf@vger.kernel.org
Cc:     sinquersw@gmail.com, ast@kernel.org, brauner@kernel.org,
        daniel@iogearbox.net, haoluo@google.com, iii@linux.ibm.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        kuifeng@meta.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, mykolal@fb.com, sdf@google.com,
        shuah@kernel.org, song@kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <cover.1698461732.git.yuran.pereira@hotmail.com>
 <DB3PR10MB6835F0ECA792265FA41FC39BE8A3A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DB3PR10MB6835F0ECA792265FA41FC39BE8A3A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 10/27/23 10:24 PM, Yuran Pereira wrote:
> Since some malloc calls in bpf_iter may at times fail,
> this patch adds the appropriate fail checks, and ensures that
> any previously allocated resource is appropriately destroyed
> before returning the function.
>
> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

