Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48DC8112E7B
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2019 16:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfLDPb0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Dec 2019 10:31:26 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57386 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728256AbfLDPbZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Dec 2019 10:31:25 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB4FTVrB117073;
        Wed, 4 Dec 2019 15:31:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2019-08-05;
 bh=3HXTEHGjRHmK560JTL3C3ZVMunILMgZmaWDSgV/yAWc=;
 b=NavOD1sqByyqk0LtmIBRd41E+pizBK+QBKTPXQorgMkOR3N34bUeKcga6ZksLatgdlpZ
 ecF3d7hB8Vim/ut4EfNnmXVw9thzBFtAR1KiEkWKgmwwCA2BjcbfjakIx7njcy7Mtyrn
 dwJCWhspPecbwtaeCJ7RHU0cs8ZpDyKXJp2aH2JWVMpG1NAxOO8oHV2eMvHQ4vONYgIm
 Nq5egI+u32gElcEVuwuJyrB06P9qwSc48jDrUUx42dEb7Ei/xWdp9evKaQznaRKm1mko
 Wy0rEi83SfZ1+BDcbHDAz+sWiMGU8/nojfMUxj+ZRfIFau1mQslp+KjKUIqlqEjMCT3v gA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2wkgcqf3wv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Dec 2019 15:31:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB4FTODa195008;
        Wed, 4 Dec 2019 15:31:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2wp16aytx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Dec 2019 15:31:00 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB4FUxiF020567;
        Wed, 4 Dec 2019 15:30:59 GMT
Received: from dhcp-10-175-179-22.vpn.oracle.com (/10.175.179.22)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Dec 2019 07:30:59 -0800
Date:   Wed, 4 Dec 2019 15:30:46 +0000 (GMT)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@dhcp-10-175-179-22.vpn.oracle.com
To:     Iurii Zaikin <yzaikin@google.com>
cc:     Alan Maguire <alan.maguire@oracle.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Kees Cook <keescook@chromium.org>, akpm@linux-foundation.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, urezki@gmail.com,
        andriy.shevchenko@linux.intel.com, corbet@lwn.net,
        David Gow <davidgow@google.com>, adilger.kernel@dilger.ca,
        "Theodore Ts'o" <tytso@mit.edu>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Knut Omang <knut.omang@oracle.com>
Subject: Re: [PATCH v5 linux-kselftest-test 3/6] kunit: allow kunit tests to
 be loaded as a module
In-Reply-To: <CAAXuY3rYZHac4o1bqqnbR_1g12dtqmJHVp8Taky00J4-+2hwZA@mail.gmail.com>
Message-ID: <alpine.LRH.2.20.1912041530210.5511@dhcp-10-175-179-22.vpn.oracle.com>
References: <1575374868-32601-1-git-send-email-alan.maguire@oracle.com> <1575374868-32601-4-git-send-email-alan.maguire@oracle.com> <CAAXuY3rYZHac4o1bqqnbR_1g12dtqmJHVp8Taky00J4-+2hwZA@mail.gmail.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=988
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912040129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912040129
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 3 Dec 2019, Iurii Zaikin wrote:

> > +ifeq ($(CONFIG_EXT4_KUNIT_TESTS),y)
> >  ext4-$(CONFIG_EXT4_KUNIT_TESTS)                += inode-test.o
> > +else
> > +obj-$(CONFIG_EXT4_KUNIT_TESTS)         += ext4-inode-test.o
> > +ext4-inode-test-objs                   += inode-test.o
> > +endif
> Why not rename it unconditionally?
> 

Good point - I've fixed this in v6. Thanks for the review!

Alan
