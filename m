Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25F76910D6
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 19:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjBIS7O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 13:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBIS7N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 13:59:13 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751705C88B;
        Thu,  9 Feb 2023 10:59:12 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319ImTkb022928;
        Thu, 9 Feb 2023 18:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=+hw88KhkYg10X+hLyjExuHRgBwHOAz02TbGNYO+1+N4=;
 b=AyivhjVx+oHKAkfulQnAgMyKicVHYNc/fTiFsoyAQa8MnHP+GfrsuNxAtBRvFlBHE1jI
 VsdfYzQDlphjNFhAYVUwS+nKAKjmWkU8O7UPh+0KONFLu2GH7/fhzAq/pPCpm3kaDheN
 g5MeHsntB4PWDMYfc0yVi4f3f82nqY23irQQRBGg56SIqrAmk7ohFP2kRr7neMGWvgif
 rcccsNquXaOGoSczpxOnw0gsp+roXOsoXJf51K6N+WMRGQTHkJBRlS3bGzO7FgO1Js+M
 F0m4TcLonbdDMNMp41XI/I/drsWiPu+sM2TGDdNPn+wRoCNhZKrOjXDNyIy7Sxefj1cR 4g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nn6edg6a7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 18:58:52 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 319Ionx8031283;
        Thu, 9 Feb 2023 18:58:51 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nn6edg69u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 18:58:51 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 319I15O0017625;
        Thu, 9 Feb 2023 18:58:50 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3nhf082fy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 18:58:50 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 319IwnwZ6423104
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Feb 2023 18:58:49 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F26D58055;
        Thu,  9 Feb 2023 18:58:49 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1FF8058043;
        Thu,  9 Feb 2023 18:58:48 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown [9.65.242.162])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  9 Feb 2023 18:58:48 +0000 (GMT)
Message-ID: <c5f5b03420367dc4280cc54c36dbe03fb34fffa0.camel@linux.ibm.com>
Subject: Re: [PATCH v2 03/10] iommufd: Create access in
 vfio_iommufd_emulated_bind()
From:   Eric Farman <farman@linux.ibm.com>
To:     Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com,
        kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, alex.williamson@redhat.com, shuah@kernel.org
Cc:     yi.l.liu@intel.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, baolu.lu@linux.intel.com,
        Matthew Rosato <mjrosato@linux.ibm.com>
Date:   Thu, 09 Feb 2023 13:58:47 -0500
In-Reply-To: <6083ba9a3c1d92baf1f324d4748333d80d3de830.1675802050.git.nicolinc@nvidia.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
         <6083ba9a3c1d92baf1f324d4748333d80d3de830.1675802050.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RM_Pp-M7EO8C3aKgve0my-uIuqw531jR
X-Proofpoint-ORIG-GUID: YAbOYRxR286bxeE-y5Lp0HdiPDuZSnyx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_15,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0 spamscore=0
 bulkscore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302090174
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

T24gVHVlLCAyMDIzLTAyLTA3IGF0IDEzOjE3IC0wODAwLCBOaWNvbGluIENoZW4gd3JvdGU6Ci4u
LnNuaXAuLi4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZmlvL2lvbW11ZmQuYyBiL2RyaXZlcnMv
dmZpby9pb21tdWZkLmMKPiBpbmRleCAwMjZmODFhODdkZDcuLmRjOWZlYWI3M2RiNyAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL3ZmaW8vaW9tbXVmZC5jCj4gKysrIGIvZHJpdmVycy92ZmlvL2lvbW11
ZmQuYwo+IEBAIC0xNDEsMTAgKzE0MSwxOSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGlvbW11ZmRf
YWNjZXNzX29wcwo+IHZmaW9fdXNlcl9vcHMgPSB7Cj4gwqBpbnQgdmZpb19pb21tdWZkX2VtdWxh
dGVkX2JpbmQoc3RydWN0IHZmaW9fZGV2aWNlICp2ZGV2LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgaW9tbXVmZF9j
dHggKmljdHgsIHUzMgo+ICpvdXRfZGV2aWNlX2lkKQo+IMKgewo+ICvCoMKgwqDCoMKgwqDCoHN0
cnVjdCBpb21tdWZkX2FjY2VzcyAqdXNlcjsKPiArCj4gwqDCoMKgwqDCoMKgwqDCoGxvY2tkZXBf
YXNzZXJ0X2hlbGQoJnZkZXYtPmRldl9zZXQtPmxvY2spOwo+IMKgCj4gLcKgwqDCoMKgwqDCoMKg
dmRldi0+aW9tbXVmZF9pY3R4ID0gaWN0eDsKPiDCoMKgwqDCoMKgwqDCoMKgaW9tbXVmZF9jdHhf
Z2V0KGljdHgpOwo+ICvCoMKgwqDCoMKgwqDCoHVzZXIgPSBpb21tdWZkX2FjY2Vzc19jcmVhdGUo
dmRldi0+aW9tbXVmZF9pY3R4LAo+ICZ2ZmlvX3VzZXJfb3BzLCB2ZGV2KTsKPiArwqDCoMKgwqDC
oMKgwqBpZiAoSVNfRVJSKHVzZXIpKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGlvbW11ZmRfY3R4X3B1dCh2ZGV2LT5pb21tdWZkX2ljdHgpOwoKTWF0dGhldyBub3RpY2VkIGEg
dmZpby1jY3cgYW5kIC1hcCByZWdyZXNzaW9uIHRoYXQgYmxhbWVzIHRoaXMgcGF0Y2guCgpQcm9i
YWJseSBib3RoIHRoZSBpb21tdWZkX2FjY2Vzc19jcmVhdGUoKSBhbmQgaW9tbXVmZF9jdHhfcHV0
KCkgY2FsbHMKd2FudCB0aGUgaWN0eCB2YXJpYWJsZSBpdHNlbGYsIGluc3RlYWQgb2YgdGhlICh1
bmluaXRpYWxpemVkKSBwb2ludGVyCmluIHRoZSB2ZmlvX2RldmljZS4gKEF0IGxlYXN0IHRoYXQg
Z2V0cyAtY2N3IGFuZCAtYXAgd29ya2luZyBhZ2Fpbi4pCgpUaGFua3MsCkVyaWMKCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBQVFJfRVJSKHVzZXIpOwo+ICvCoMKgwqDC
oMKgwqDCoH0KPiArwqDCoMKgwqDCoMKgwqBpb21tdWZkX2FjY2Vzc19zZXRfaW9hcyh1c2VyLCAw
KTsKPiArwqDCoMKgwqDCoMKgwqB2ZGV2LT5pb21tdWZkX2FjY2VzcyA9IHVzZXI7Cj4gK8KgwqDC
oMKgwqDCoMKgdmRldi0+aW9tbXVmZF9pY3R4ID0gaWN0eDsKPiDCoMKgwqDCoMKgwqDCoMKgcmV0
dXJuIDA7Cj4gwqB9Cj4gwqBFWFBPUlRfU1lNQk9MX0dQTCh2ZmlvX2lvbW11ZmRfZW11bGF0ZWRf
YmluZCk7Cgo=

