Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F53A628B67
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Nov 2022 22:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236661AbiKNVio (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Nov 2022 16:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236250AbiKNVin (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Nov 2022 16:38:43 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7B45F99;
        Mon, 14 Nov 2022 13:38:43 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id k7so11323097pll.6;
        Mon, 14 Nov 2022 13:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F3cNtXN2DB64Euf++r92xZMp5o5c66s1GZnHINfFu+k=;
        b=V8q7Aq1Da67HmHyjjYKF4mvnaJAwQFZsxa8vqRh7Qu2wfSYg3MBtNjAAx4ue31AYuk
         bagcYPnIBo5rHRdjT4+VD3n7N1PvjZfwNCCxTJD3isLmrOSTNOcNXDG7ltjvL9JAIaiP
         afYsNemfGGnr/o6LwRDH+n8RLSnk8Wb/9nT+nldCNkmIRJ/NOHVK2IWZRzamVXVMMUaR
         OwdvtnTQapzzea4cb8U00v7/OPaEzL/9z8NfHIz3tbnPeUX04Hfk1mght+W+gUOwxaRl
         vkWZE6SfQviwLqH+urmpFTVI77sNvtVz1OxD0Gq7JvCQaUHc6c3frwCJFpDSBNLv8PTB
         qY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3cNtXN2DB64Euf++r92xZMp5o5c66s1GZnHINfFu+k=;
        b=CzLZRp2NITdzjvEb2vnPzyDLG/Z1YWgX/2G6RxS7QIGH85AQgE2Oo+cnbvmuoxxPUw
         ikRqfsVBrBMtT3vwZUSc5l3DF/og/Ifs1JNvG6N1ARH1kfkZ5JnjhKXUsoEqafKty0d4
         klcHCNvAaKUERmB1c9rkX+PB64a7UwKSojp4x3WspDFBlL/EefWZWm1LSfFzdniRpPVa
         j2Ks8ZBLfLJzyQLIWXsofXb4QqR3mzOEEwJum2yJ9W/pvwDK4MiNxHzSR+mNNISe9UDp
         MKpNt/6huPVE2Ovn0751VjtECp36G7cqsd/PyfIuEnf6aF7cciryNsDdLTBO7Dm9s7xj
         fqTg==
X-Gm-Message-State: ANoB5pktMS6P7rlFbB4C7GkzysNYTMJhMCDwP8hMwnjEyUq72tnty6e7
        9a8aSSR0JEHFC9Xg4rsV+nU=
X-Google-Smtp-Source: AA0mqf4c1YIr7bKbDBIgsM4V8OmHeGRqpAIPNVPmRwWizkic0Bg3mEYAJds5xbVDhU+G1hND394/uA==
X-Received: by 2002:a17:902:b716:b0:17f:8f89:3ee8 with SMTP id d22-20020a170902b71600b0017f8f893ee8mr1058347pls.122.1668461922248;
        Mon, 14 Nov 2022 13:38:42 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id h23-20020a632117000000b0046ffe3fea77sm6343129pgh.76.2022.11.14.13.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 13:38:41 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 14 Nov 2022 11:38:40 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Breno Leitao <leitao@debian.org>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org, shuah@kernel.org,
        cgroups@vger.kernel.org, leit@meta.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/cgroup: Fix gathering number of CPUs
Message-ID: <Y3K1YBoFvZ8Vmi+a@slm.duckdns.org>
References: <20221113114449.18693-1-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221113114449.18693-1-leitao@debian.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Nov 13, 2022 at 11:44:49AM +0000, Breno Leitao wrote:
> test_cpuset_prs.sh is failing with the following error:
> 
> 	test_cpuset_prs.sh: line 29: [[: 8
> 	57%: syntax error in expression (error token is "57%")
> 
> This is happening because `lscpu | grep "^CPU(s)"` returns two lines in
> some systems (such as Debian unstable):
> 
> 	# lscpu | grep "^CPU(s)"
> 	CPU(s):                          8
> 	CPU(s) scaling MHz:              55%
> 
> This is a simple fix that discard the second line.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Applied to cgroup/for-6.1-fixes.

Thanks.

-- 
tejun
