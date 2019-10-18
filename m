Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE9B9DBDC2
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2019 08:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393476AbfJRGmD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Oct 2019 02:42:03 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:54879 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730508AbfJRGmC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Oct 2019 02:42:02 -0400
X-IronPort-AV: E=Sophos;i="5.67,310,1566835200"; 
   d="scan'208";a="77146353"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Oct 2019 14:42:01 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id E3E3A4CE1503;
        Fri, 18 Oct 2019 14:41:33 +0800 (CST)
Received: from localhost.localdomain (10.167.226.81) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Fri, 18 Oct 2019 14:41:56 +0800
Subject: Re: [Bug report] "make run_tests -C bpf" hanging forever
From:   Liu Yiding <liuyd.fnst@cn.fujitsu.com>
To:     Kees Cook <keescook@chromium.org>
CC:     <linux-kselftest@vger.kernel.org>,
        Prabhakar Kushwaha <prabhakar.pkin@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Philip Li <philip.li@intel.com>
References: <d08b43ee-6a21-c9aa-ea7b-9465ecbad772@cn.fujitsu.com>
Message-ID: <05dbae1d-05de-8360-5f3c-a698d4dc3226@cn.fujitsu.com>
Date:   Fri, 18 Oct 2019 14:41:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <d08b43ee-6a21-c9aa-ea7b-9465ecbad772@cn.fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-yoursite-MailScanner-ID: E3E3A4CE1503.ABBA2
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: liuyd.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

CC LKP mainter


On 10/18/19 2:32 PM, Liu Yiding wrote:
> Hi All.
>
> The patch 5c069b6dedef "selftests: Move test output to diagnostic 
> lines" from Apr 24, 2019,
>
> leads to `make run_tests -C bpf` hanging forever.
>
>
> Bpf includes many subtest, when cmd `make run_tests -C bpf` runs to 
> test_lwt_seg6local.sh, task will hang and runner.sh never run next 
> task. I checked ps aux, prefix.pl will never exit.
>
> ```
>
> 91058 [  811.451584] # [25] VAR __license type_id=24 linkage=1
> 91059 [  811.451586]-
> 91060 [  811.455365] # [26] DATASEC license size=0 vlen=1 size == 0
> 91061 [  811.455367]-
> 91062 [  811.457424] #-
> 91063 [  811.457425]-
> 91064 [  811.460912] # selftests: test_lwt_seg6local [PASS]
> 91065 [  811.460914]-
> 91066 [ 3620.461986] Thu Oct 17 14:54:05 CST 2019 detected soft_timeout
>
> ```
>
> Ignore test_lwt_seg6local and run `make run_tests -C bpf` again, task 
> will hang on test_tc_tunnel.sh.
>
>
> Kushwaha also meet this issue, `make run_tests -C bpf` hang on 
> test_lwt_ip_encap.sh (This test failed on my localhost).
>
-- 
Best regards.
Liu Yiding



