Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2351A6B8D
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Apr 2020 19:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732945AbgDMRkN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Apr 2020 13:40:13 -0400
Received: from mga14.intel.com ([192.55.52.115]:20065 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732941AbgDMRkN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Apr 2020 13:40:13 -0400
IronPort-SDR: a/wTV2e7FoIt+Egf2Zt/11NpncYYf5yQcPBFNB3/Vc/qV2sqNNHyMMAKIpUqpuZJJhKRSxn17R
 cunqoaA4MLog==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 10:39:12 -0700
IronPort-SDR: wiAHJ4KIneuxAP4rm2G7cyHYAquz0lH6F6nhpgNXS0G2CkN2ZzOWn58IDdWhhczoInuhY10Cl7
 Hw5m1tjuH3bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; 
   d="scan'208";a="276969663"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by fmsmga004.fm.intel.com with ESMTP; 13 Apr 2020 10:39:12 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.205]) by
 ORSMSX109.amr.corp.intel.com ([169.254.11.20]) with mapi id 14.03.0439.000;
 Mon, 13 Apr 2020 10:39:11 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        David Binderman <dcb314@hotmail.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: linux-5.7-rc1/tools/testing/selftests/resctrl/cqm_test.c:89:15:
 error: Buffer is accessed out of bounds
Thread-Topic: linux-5.7-rc1/tools/testing/selftests/resctrl/cqm_test.c:89:15: error:
 Buffer is accessed out of bounds
Thread-Index: AQHWEbDfJ6fzYiZKSEetFvBTCfNON6h3TNdA
Date:   Mon, 13 Apr 2020 17:39:11 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F57374492@ORSMSX114.amr.corp.intel.com>
References: <DB7PR08MB38010E1B93EEE780A48EBBB39CDD0@DB7PR08MB3801.eurprd08.prod.outlook.com>
 <fcc738e6-0cff-d605-2e28-cd756921c981@intel.com>
In-Reply-To: <fcc738e6-0cff-d605-2e28-cd756921c981@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> -----Original Message-----
> From: Reinette Chatre <reinette.chatre@intel.com>
> Sent: Monday, April 13, 2020 9:31 AM
> To: David Binderman <dcb314@hotmail.com>; Yu, Fenghua
> <fenghua.yu@intel.com>; shuah@kernel.org; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; linux-kselftest@vger.kernel.org; Prakhya, Sai Praneeth
> <sai.praneeth.prakhya@intel.com>
> Subject: Re: linux-5.7-rc1/tools/testing/selftests/resctrl/cqm_test.c:89:15:
> error: Buffer is accessed out of bounds
> 
> +Sai
> 
> On 4/13/2020 2:43 AM, David Binderman wrote:
> > Hello there,
> >
> > Source code is
> >
> >    while (fgets(temp, 1024, fp)) {
> >
> > but
> >
> >     char *token_array[8], temp[512];
> >
> > Use of compiler flag -D_FORTIFY_SOURCE=2 would have found the problem.
> > For example:
> >
> > # include <stdio.h>
> >
> > extern void g( int);
> >
> > void
> > f( FILE * fp)
> > {
> > 	char buf[ 100];
> >
> > 	while (fgets( buf, 200, fp) != 0)
> > 	{
> > 		g( 1);
> > 	}
> > }
> >
> > gives
> >
> > $ /home/dcb/gcc/results/bin/gcc -c -g -O2 -D_FORTIFY_SOURCE=2
> > apr13c.cc In file included from /usr/include/stdio.h:867,
> >                  from apr13c.cc:2:
> > In function 'char* fgets(char*, int, FILE*)',
> >     inlined from 'void f(FILE*)' at apr13c.cc:11:14:
> > /usr/include/bits/stdio2.h:263:26: warning: call to '__fgets_chk_warn'
> > declared with attribute warning: fgets called with bigger size than
> > length of destination buffer [-Wattribute-warning]
> >
> > I suggest switch on compiler flag -D_FORTIFY_SOURCE=2 in all
> > development builds.
> >
> 
> Thank you very much for catching this David.
> 
> Sai: could you include this fix in your upcoming series of fixes? Using the pattern
> of "fgets(buf, sizeof(buf), ...)" instead of hard coding the size should be helpful
> here.

Reinette: Sure! I will include this fix. Just FYI, I did notice this and have fixed it in V1 patches that I sent out earlier.

David: Thanks for bringing this up. I wasn't aware of the gcc flag you had mentioned. I will add it.

Regards,
Sai
