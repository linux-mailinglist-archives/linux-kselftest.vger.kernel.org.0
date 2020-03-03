Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C49517734F
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Mar 2020 11:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbgCCKAR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Mar 2020 05:00:17 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:40674 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726694AbgCCKAR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Mar 2020 05:00:17 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 25233E88490DF10B5032;
        Tue,  3 Mar 2020 18:00:13 +0800 (CST)
Received: from DGGEMM421-HUB.china.huawei.com (10.1.198.38) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 3 Mar 2020 18:00:12 +0800
Received: from DGGEMM528-MBX.china.huawei.com ([169.254.8.90]) by
 dggemm421-hub.china.huawei.com ([10.1.198.38]) with mapi id 14.03.0439.000;
 Tue, 3 Mar 2020 18:00:06 +0800
From:   "Zhoujian (jay)" <jianjay.zhou@huawei.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC:     "peterx@redhat.com" <peterx@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wangxin (U)" <wangxinxin.wang@huawei.com>,
        "Huangweidong (C)" <weidong.huang@huawei.com>,
        "Liujinsong (Paul)" <liu.jinsong@huawei.com>
Subject: RE: [PATCH] kvm: selftests: Support dirty log initial-all-set test
Thread-Topic: [PATCH] kvm: selftests: Support dirty log initial-all-set test
Thread-Index: AQHV8TLCY4Xj3pfMjkOXUb/5I4t9Iqg2Ch2AgACW2iA=
Date:   Tue, 3 Mar 2020 10:00:05 +0000
Message-ID: <B2D15215269B544CADD246097EACE7474BB4E091@DGGEMM528-MBX.china.huawei.com>
References: <20200303080710.1672-1-jianjay.zhou@huawei.com>
 <f0c2dcb8-4415-eec9-d181-fb29d206c55c@redhat.com>
In-Reply-To: <f0c2dcb8-4415-eec9-d181-fb29d206c55c@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.228.206]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> -----Original Message-----
> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> Sent: Tuesday, March 3, 2020 4:54 PM
> To: Zhoujian (jay) <jianjay.zhou@huawei.com>; kvm@vger.kernel.org
> Cc: peterx@redhat.com; shuah@kernel.org; linux-kselftest@vger.kernel.org;
> linux-kernel@vger.kernel.org; wangxin (U) <wangxinxin.wang@huawei.com>;
> Huangweidong (C) <weidong.huang@huawei.com>; Liujinsong (Paul)
> <liu.jinsong@huawei.com>
> Subject: Re: [PATCH] kvm: selftests: Support dirty log initial-all-set test
> 
> On 03/03/20 09:07, Jay Zhou wrote:
> >  #ifdef USE_CLEAR_DIRTY_LOG
> > -	if (!kvm_check_cap(KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2)) {
> > -		fprintf(stderr, "KVM_CLEAR_DIRTY_LOG not available, skipping
> tests\n");
> > +	dirty_log_manual_caps =
> > +		kvm_check_cap(KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2);
> > +	if (!dirty_log_manual_caps) {
> > +		fprintf(stderr, "KVM_CLEAR_DIRTY_LOG not available, "
> > +				"skipping tests\n");
> > +		exit(KSFT_SKIP);
> > +	}
> > +	if (dirty_log_manual_caps != KVM_DIRTY_LOG_MANUAL_CAPS &&
> > +		dirty_log_manual_caps !=
> KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE) {
> > +		fprintf(stderr, "KVM_CLEAR_DIRTY_LOG not valid caps "
> > +				"%"PRIu64", skipping tests\n",
> > +				dirty_log_manual_caps);
> >  		exit(KSFT_SKIP);
> >  	}
> >  #endif
> >
> 
> Thanks, instead of this final "if" it should be enough to do
> 
> 	dirty_log_manual_caps &= (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE
> |
> 				  KVM_DIRTY_LOG_INITIALLY_SET);
> 
> 
> Otherwise looks good, I'll test it and eventually apply both patches.

Do I need to resubmit this patch with this modification?

Regards,
Jay Zhou

> 
> Paolo

