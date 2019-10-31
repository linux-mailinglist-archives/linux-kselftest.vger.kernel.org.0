Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4675EAB17
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2019 08:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfJaHoZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Oct 2019 03:44:25 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47878 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfJaHoZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Oct 2019 03:44:25 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9V7i7Re029589;
        Thu, 31 Oct 2019 07:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=UJq0GuSeiAGq0pMGkmaU4zIL7MNZOdSl8Rq18xN+PfQ=;
 b=iI4lBDdyIAzBxP0cileGIQzISELbfAoNv23ij4kqk+CtjgML0U2FdpE5LzklOiUlmcrl
 HGG++KbBrFe5QcgWfujcAsEyO0Ci0VYI8jBlZRBQ2NNtUf9F5rV6u31dx5STvIAaBZgA
 Pd9vsYF5KkANXB/DPTFVA/KmXwqCHc+sB46BYztcra7GteAbAsWLZlxZLWnUVIqq6uxE
 2HIyttXLMjoa0WzoItKjGMukhkHD3e8++zV3gepFkOeuGi6/+R8fnbXeT6TBnCOqcZVZ
 U1IT1qxXr/OB2IDBtbPHRSgWlwN7YJ4U8ml5rwi/nec6Mr/03FPnYlXh1vZMRsRwbGKU Yw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2vxwhfsb8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 07:44:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9V7i2E5058050;
        Thu, 31 Oct 2019 07:44:14 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2vysbtnwu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 07:44:14 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9V7h7jb028429;
        Thu, 31 Oct 2019 07:43:07 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 31 Oct 2019 00:43:06 -0700
Date:   Thu, 31 Oct 2019 10:42:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     David Gow <davidgow@google.com>
Cc:     Joe Perches <joe@perches.com>, shuah <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-kselftest/test v6] lib/list-test: add a test for
 the 'list' doubly linked list
Message-ID: <20191031074256.GE18421@kadam>
References: <20191024224631.118656-1-davidgow@google.com>
 <0cb1d948-0da3-eb0f-c58f-ae3a785dd0dd@kernel.org>
 <CABVgOSmCHbGjZBjeWSbPEZbJw22SaBQnoO77xxNzN_ugAwzNiQ@mail.gmail.com>
 <20191030104217.GA18421@kadam>
 <42a8270d-ed6f-d29f-5e71-7b76a074b63e@kernel.org>
 <20191030191255.GD18421@kadam>
 <f665ec7b21527c7095a61dd5c2f48fd00df0d5c9.camel@perches.com>
 <CABVgOSkKCXodwi=RcmRpB+t157surmEjq2b+92VQQD2Cy0WTvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSkKCXodwi=RcmRpB+t157surmEjq2b+92VQQD2Cy0WTvA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=952
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910310077
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910310077
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

David, this is an easy question to answer.  I think Shuah is the
maintainer here?  You don't have to make everyone happy, you just have
to make Shuah happy.  Joe and I have very little emotional investment in
this code and we don't care what you do and even if we did, it wouldn't
matter.

regards,
dan carpenter
