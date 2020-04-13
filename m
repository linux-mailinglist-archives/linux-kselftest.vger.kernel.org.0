Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79571A69F7
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Apr 2020 18:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbgDMQan (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Apr 2020 12:30:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:5348 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731587AbgDMQam (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Apr 2020 12:30:42 -0400
IronPort-SDR: 0UjSJ/RMfCiNIX0Hh3JAdOmfgE0+nvpvGr9R1lCZzMTkujWXkRbXhHGq7f+xKllFwPbD+NdFmR
 YrQ68/LQiEnQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 09:30:42 -0700
IronPort-SDR: YrPaTfiJBoTLNJE0b55d6fX275Obm/Ipg/2Y6SdKePOLQjN8gmg8/wMGZv8V3anyfg+1V056T+
 3SYUxrodWw1Q==
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; 
   d="scan'208";a="256226157"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.254.108.87]) ([10.254.108.87])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 09:30:41 -0700
Subject: Re: linux-5.7-rc1/tools/testing/selftests/resctrl/cqm_test.c:89:15:
 error: Buffer is accessed out of bounds
To:     David Binderman <dcb314@hotmail.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
References: <DB7PR08MB38010E1B93EEE780A48EBBB39CDD0@DB7PR08MB3801.eurprd08.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <fcc738e6-0cff-d605-2e28-cd756921c981@intel.com>
Date:   Mon, 13 Apr 2020 09:30:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <DB7PR08MB38010E1B93EEE780A48EBBB39CDD0@DB7PR08MB3801.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

+Sai

On 4/13/2020 2:43 AM, David Binderman wrote:
> Hello there,
> 
> Source code is
> 
>    while (fgets(temp, 1024, fp)) {
> 
> but
> 
>     char *token_array[8], temp[512];
> 
> Use of compiler flag -D_FORTIFY_SOURCE=2 would have found the problem.
> For example:
> 
> # include <stdio.h>
> 
> extern void g( int);
> 
> void
> f( FILE * fp)
> {
> 	char buf[ 100];
> 
> 	while (fgets( buf, 200, fp) != 0)
> 	{
> 		g( 1);
> 	}
> }
> 
> gives
> 
> $ /home/dcb/gcc/results/bin/gcc -c -g -O2 -D_FORTIFY_SOURCE=2 apr13c.cc
> In file included from /usr/include/stdio.h:867,
>                  from apr13c.cc:2:
> In function ‘char* fgets(char*, int, FILE*)’,
>     inlined from ‘void f(FILE*)’ at apr13c.cc:11:14:
> /usr/include/bits/stdio2.h:263:26: warning: call to ‘__fgets_chk_warn’ declared with attribute warning: fgets called with bigger size than length of destination buffer [-Wattribute-warning]
> 
> I suggest switch on compiler flag -D_FORTIFY_SOURCE=2 in
> all development builds.
> 

Thank you very much for catching this David.

Sai: could you include this fix in your upcoming series of fixes? Using
the pattern of "fgets(buf, sizeof(buf), ...)" instead of hard coding the
size should be helpful here.

Reinette



