Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBE3EB6F1
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2019 19:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbfJaSbK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Oct 2019 14:31:10 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11080 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729275AbfJaSbK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Oct 2019 14:31:10 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dbb28740000>; Thu, 31 Oct 2019 11:31:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 31 Oct 2019 11:31:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 31 Oct 2019 11:31:09 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 31 Oct
 2019 18:31:09 +0000
From:   Ralph Campbell <rcampbell@nvidia.com>
Subject: Question about where to put test drivers
X-Nvconfidentiality: public
To:     <linux-kselftest@vger.kernel.org>
Message-ID: <6123a6b8-5726-862a-dcea-0a7a90acbc19@nvidia.com>
Date:   Thu, 31 Oct 2019 11:31:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1572546676; bh=OMBJ/nWGNXycE2q/AxDRA4P9ZYNTY0rwdjqx5QdTK+k=;
        h=X-PGP-Universal:From:Subject:X-Nvconfidentiality:To:Message-ID:
         Date:User-Agent:MIME-Version:X-Originating-IP:X-ClientProxiedBy:
         Content-Type:Content-Language:Content-Transfer-Encoding;
        b=kw/uaPkD7Qo/L4iQc9tr2SDQiY8GMqLRcTPGBuF37SFEQSNk4wyiQf1+1VdoatsRM
         YOlRgxxVDp1skycAcBvuR7DX77GPXuuFgXn4WQh7ECnpThnyQSz3pnW/Ngqetm99uM
         ZKudmLuOR8uWspR56hqfbqrkUCPP7U0Zf/m5xs06B/x3VEyI1qdO7lYsQAo68ZFK/9
         3rrz9wZvVF9GdFvwZT+G/uiY89Ov7+Jabq9tckCq/TMOYpsZAU3iuJr6IEx1dqlV6i
         u1RdxyKjr2pV0z+ZXSioeYXCxgdwyER8nid140Peerm3Y+lDUVyy29hzlHVa65CFiX
         Np6UN4HiqpX5g==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

I'm planning to add some kernel self tests which use a user level program
in tools/testing/selftests/vm/ and a kernel module. See:
https://lore.kernel.org/linux-mm/20191023195515.13168-1-rcampbell@nvidia.com/

The question is where to put the kernel module source code.
I see some test modules that are in lib/test_*.ko and my patch
initially placed the hmm-dmirror module in drivers/char/ since
it creates a character device.

Any advice?
