Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCF57001E7
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 May 2023 09:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240332AbjELHz0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 May 2023 03:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240371AbjELHzK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 May 2023 03:55:10 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE6B10E6E;
        Fri, 12 May 2023 00:54:46 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34C7rx46019116;
        Fri, 12 May 2023 07:54:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : content-transfer-encoding : in-reply-to : references :
 subject : from : cc : to : message-id : date; s=pp1;
 bh=Oabtk3hQqAa8sozr8srNkRpZAsz5NhlixSvyWx1v3v4=;
 b=mr2Ufo7XEx49bMn49ztnkUk3VnAY+u4RfPk4VOB1xJQjpWs5jRPYAT2VdFMLhngPxqT1
 QKkT4RBsPKL4RpPo8zYmVqhfIloVDObEVC519edRm+kbOLj0iP13viLXMUrOiln3JiAy
 SEqE0wbR2+NgLVHwP9SbHQL1Gg2fHVue67coAKjXpl02MOeu1EIc9V3GBih0rzmzpecz
 BlW4t+z/5+I9q0kI0p6dcIe/OjzdXdePXsZrTr0rQ9CGaq/dA9/+ntbgJ9Em2PkaBMFe
 uKOKu6sTgBYLJnF8faNj5BV5IEepsATdQO8NTgTRcUGTzoNKo3RD+OIegtUm9lIzpxIb Ng== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qhhfkr07m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 07:54:11 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34C5Nj75010604;
        Fri, 12 May 2023 07:54:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3qf84ea702-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 07:54:08 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34C7s5wh42664332
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 07:54:05 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A97A20043;
        Fri, 12 May 2023 07:54:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDAEE2004D;
        Fri, 12 May 2023 07:54:04 +0000 (GMT)
Received: from t14-nrb (unknown [9.179.18.132])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 12 May 2023 07:54:04 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230324145424.293889-2-nrb@linux.ibm.com>
References: <20230324145424.293889-1-nrb@linux.ibm.com> <20230324145424.293889-2-nrb@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] KVM: s390: fix KVM_S390_GET_CMMA_BITS for GFNs in memslot holes
From:   Nico Boehr <nrb@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org
To:     borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, shuah@kernel.org
Message-ID: <168387804450.70017.1336294171311719978@t14-nrb>
User-Agent: alot/0.8.1
Date:   Fri, 12 May 2023 09:54:04 +0200
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: c6A1cYR4Mn31ooSHr3EFQGmXiwSEImiG
X-Proofpoint-ORIG-GUID: c6A1cYR4Mn31ooSHr3EFQGmXiwSEImiG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 mlxlogscore=731 clxscore=1015 phishscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120064
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Quoting Nico Boehr (2023-03-24 15:54:23)
> The KVM_S390_GET_CMMA_BITS ioctl may return incorrect values when userspa=
ce
> specifies a start_gfn outside of memslots.
>=20
> This can occur when a VM has multiple memslots with a hole in between:
>=20
> +-----+----------+--------+--------+
> | ... | Slot N-1 | <hole> | Slot N |
> +-----+----------+--------+--------+
>       ^          ^        ^        ^
>       |          |        |        |
> GFN   A          A+B      |        |
>                           A+B+C    |
>                                    A+B+C+D
>=20
> When userspace specifies a GFN in [A+B, A+B+C), it would expect to get the
> CMMA values of the first dirty page in Slot N. However, userspace may get=
 a
> start_gfn of A+B+C+D with a count of 0, hence completely skipping over any
> dirty pages in slot N.
>=20
> The error is in kvm_s390_next_dirty_cmma(), which assumes
> gfn_to_memslot_approx() will return the memslot _below_ the specified GFN
> when the specified GFN lies outside a memslot. In reality it may return
> either the memslot below or above the specified GFN.
>=20
> When a memslot above the specified GFN is returned this happens:
>=20
> - ofs is calculated, but since the memslot's base_gfn is larger than the
>   specified cur_gfn, ofs will underflow to a huge number.
> - ofs is passed to find_next_bit(). Since ofs will exceed the memslot's
>   number of pages, the number of pages in the memslot is returned,
>   completely skipping over all bits in the memslot userspace would be
>   interested in.
>=20
> Fix this by resetting ofs to zero when a memslot _above_ cur_gfn is
> returned (cur_gfn < ms->base_gfn).
>=20
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Since Janosch asked for it, I would suggest the following Fixes tag:

Fixes: afdad61615cc ("KVM: s390: Fix storage attributes migration with memo=
ry slots")
