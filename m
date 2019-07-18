Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 749456D156
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2019 17:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfGRPsh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Jul 2019 11:48:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9130 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727757AbfGRPsh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Jul 2019 11:48:37 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6IFhCVV096843
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Jul 2019 11:48:36 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ttum1gcqg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Jul 2019 11:48:35 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kselftest@vger.kernel.org> from <iii@linux.ibm.com>;
        Thu, 18 Jul 2019 16:48:33 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 18 Jul 2019 16:48:31 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6IFmUaI39780576
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jul 2019 15:48:30 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8AEA411C050;
        Thu, 18 Jul 2019 15:48:30 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68A9811C05E;
        Thu, 18 Jul 2019 15:48:30 +0000 (GMT)
Received: from dyn-9-152-99-77.boeblingen.de.ibm.com (unknown [9.152.99.77])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 18 Jul 2019 15:48:30 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: "make" vs "$(MAKE)" in tools/testing/selftests/Makefile
Date:   Thu, 18 Jul 2019 17:48:30 +0200
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
To:     linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        keescook@chromium.org
X-Mailer: Apple Mail (2.3445.9.1)
X-TM-AS-GCONF: 00
x-cbid: 19071815-0012-0000-0000-000003341B86
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071815-0013-0000-0000-0000216D9E3B
Message-Id: <AE9B539F-DEBE-4CE2-91DB-9EA2DA2A9DEA@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=666 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907180163
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

Is there a reason why kselftest Makefile uses plain "make" instead of
"$(MAKE)"?

Because of this, "make kselftest TARGETS=bpf -j12" ends up building all
bpf tests sequentially, since the top make's jobserver is not shared
with its children. Replacing "make" with "$(MAKE)" helps, but since
other Makefiles use "$(MAKE)", it looks as if this has been done
intentionally.

Best regards,
Ilya

