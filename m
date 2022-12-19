Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4961765100C
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Dec 2022 17:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbiLSQON (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Dec 2022 11:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiLSQOC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Dec 2022 11:14:02 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EE2DF46;
        Mon, 19 Dec 2022 08:14:01 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJGD177026411;
        Mon, 19 Dec 2022 16:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ZsydaWwORy2lc4YtcUfyBIIbjUIfDmjxIjEgD4QMMpg=;
 b=tZCi6XA9crFra2SZQSW+VcfqM0OcrCkWB6INgwJR3EUetKUUt/meawuj7CrJsz2uzmNE
 tRYyXu269XALwp6F8eil82lFFGqkZt4zJdWlseSurxzuLZIlCV86/2x9MyshgU1LWprp
 wI7RM42L4ZP5BEyq/wN5rttLFdRdnbvc4hL5tNsWaOStGRQdrVUUdVSsPmSM5Tj9/Hrr
 36wmTP7o2GDIiAM0yImHilpZClgnAGhkRZ1IZ7chXyFnzfvOoZvPRr4aClFrlgFQSU68
 YVyLv3C9KSybNlKHNpJjhMq5dmzCtfJcGINV+tn6gdYqYmZjgrbp0IfH/knZs3VqNky6 /g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mju9eg3fu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 16:13:47 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BJGDBA9028467;
        Mon, 19 Dec 2022 16:13:42 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mju9eg2u0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 16:13:42 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJE7c6s024486;
        Mon, 19 Dec 2022 16:13:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3mh6ywjsym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 16:13:24 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BJGDLrK25559646
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Dec 2022 16:13:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 051062004E;
        Mon, 19 Dec 2022 16:13:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9ACC620040;
        Mon, 19 Dec 2022 16:13:20 +0000 (GMT)
Received: from li-7e0de7cc-2d9d-11b2-a85c-de26c016e5ad.ibm.com (unknown [9.171.170.124])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 19 Dec 2022 16:13:20 +0000 (GMT)
Message-ID: <fbe79380237a2d6f4aca0c6b6909afd20b35a058.camel@linux.ibm.com>
Subject: Re: [PATCH v4 5/9] KVM: s390: selftest: memop: Move testlist into
 main
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>
Date:   Mon, 19 Dec 2022 17:13:20 +0100
In-Reply-To: <20221213165405.2953539-6-scgl@linux.ibm.com>
References: <20221213165405.2953539-1-scgl@linux.ibm.com>
         <20221213165405.2953539-6-scgl@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NATjA8NPGe-CT4G3UaXDW_WsM-6vcUjA
X-Proofpoint-GUID: LZKs_1CA8sNAPc1PXH-HZy3FrXVqtTCy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212190142
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 2022-12-13 at 17:54 +0100, Janis Schoetterl-Glausch wrote:
> This allows checking if the necessary requirements for a test case are
> met via an arbitrary expression. In particular, it is easy to check if
> certain bits are set in the memop extension capability.
>=20
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  tools/testing/selftests/kvm/s390x/memop.c | 132 +++++++++++-----------
>  1 file changed, 66 insertions(+), 66 deletions(-)
>=20
> diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/se=
lftests/kvm/s390x/memop.c
> index 286185a59238..10f34c629cac 100644
> --- a/tools/testing/selftests/kvm/s390x/memop.c
> +++ b/tools/testing/selftests/kvm/s390x/memop.c
> @@ -690,87 +690,87 @@ static void test_errors(void)
>  	kvm_vm_free(t.kvm_vm);
>  }
> =20
[...]
> =20
>  int main(int argc, char *argv[])
>  {
>  	int extension_cap, idx;
> =20
> +	setbuf(stdout, NULL);	/* Tell stdout not to buffer its content */
>  	TEST_REQUIRE(kvm_has_cap(KVM_CAP_S390_MEM_OP));
> +	extension_cap =3D kvm_check_cap(KVM_CAP_S390_MEM_OP_EXTENSION);
> =20
[...]
> =20
>  	ksft_print_header();
> -
>  	ksft_set_plan(ARRAY_SIZE(testlist));
> =20
> -	extension_cap =3D kvm_check_cap(KVM_CAP_S390_MEM_OP_EXTENSION);
>  	for (idx =3D 0; idx < ARRAY_SIZE(testlist); idx++) {
> -		if (extension_cap >=3D testlist[idx].extension) {
> +		if (testlist[idx].requirements_met) {
>  			testlist[idx].test();
>  			ksft_test_result_pass("%s\n", testlist[idx].name);
>  		} else {
> -			ksft_test_result_skip("%s - extension level %d not supported\n",
> -					      testlist[idx].name,
> -					      testlist[idx].extension);
> +			ksft_test_result_skip("%s - requirements not met (kernel has extensio=
n cap %#x\n)",

                                                                           =
     oops, should be )\n ofc ^

> +					      testlist[idx].name, extension_cap);
>  		}
>  	}
> =20

