Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7144D47385C
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Dec 2021 00:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244170AbhLMXXR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Dec 2021 18:23:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42368 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237678AbhLMXXR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Dec 2021 18:23:17 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDKEXYr008396;
        Mon, 13 Dec 2021 23:23:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=mVoL7t2PjoTiYtG8aTCUXrZ8kRnZgXQr3W0mbAVpegk=;
 b=db+mBPNBlnmQyOJqgMHyTYAxP4uJvRfK1mURhzLu4MVqVd4UnL9qOWXcg0a9tjS1iyMm
 dNfdOqOY7yXoNv91xc2w+R3gkVs6LfsdW7gByk1L2P7tsiQunh6xbmdoKPTYq8ch/Tpj
 4RYjeTNVEcGG+ff1FJ3unKB8inWNLFMR23C+gZbUSMo5ymKr1rY7GJSHIl7PvQfb03lV
 yALnX4JsH2IEiy6rML0bI4m3lg4XEKh6LjIjGmrutqhYMm/LGVafGThKDCJEd5+5QWqb
 Xa838TEyj2uXrdvGeAEfLvnrhP6aKEWPDsA+GX3+er2Gf9FilvqGfwm62AaofSULM31v yQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cx9r9sk0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Dec 2021 23:23:10 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BDNIP9e019702;
        Mon, 13 Dec 2021 23:23:08 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3cvk8hsc31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Dec 2021 23:23:08 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BDNFAOh44433878
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 23:15:10 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60D744C044;
        Mon, 13 Dec 2021 23:23:05 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F8174C040;
        Mon, 13 Dec 2021 23:23:04 +0000 (GMT)
Received: from sig-9-65-76-48.ibm.com (unknown [9.65.76.48])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 13 Dec 2021 23:23:03 +0000 (GMT)
Message-ID: <19fef5e47261f11298134d15ae15f49f475756ff.camel@linux.ibm.com>
Subject: Re: [PATCH 2/3] selftests/kexec: Enable secureboot tests for PowerPC
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nageswara R Sastry <rnsastry@linux.ibm.com>,
        linux-kselftest@vger.kernel.org, linux-integrity@vger.kernel.org,
        mpe@ellerman.id.au, shuah@kernel.org
Cc:     nayna@linux.ibm.com, dja@axtens.net, gcwilson@linux.ibm.com
Date:   Mon, 13 Dec 2021 18:23:03 -0500
In-Reply-To: <20211124070802.1765-2-rnsastry@linux.ibm.com>
References: <20211124070802.1765-1-rnsastry@linux.ibm.com>
         <20211124070802.1765-2-rnsastry@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vAx_KgAaHYb-fmEvmiFsB_l-y8dH7N_w
X-Proofpoint-ORIG-GUID: vAx_KgAaHYb-fmEvmiFsB_l-y8dH7N_w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-13_14,2021-12-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1011 priorityscore=1501 spamscore=0 bulkscore=0
 mlxlogscore=902 lowpriorityscore=0 mlxscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112130135
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Nageswara,

On Wed, 2021-11-24 at 12:38 +0530, Nageswara R Sastry wrote:
> Existing test cases determine secureboot state using efi variable, which is
> available only on x86 architecture.
> Add support for determining secureboot state using device tree property on
> PowerPC architecture.
> 
> Signed-off-by: Nageswara R Sastry <rnsastry@linux.ibm.com>

This patch looks fine.  I can pick this one up, once I get a Tested-by
tag.

thanks,

Mimi

