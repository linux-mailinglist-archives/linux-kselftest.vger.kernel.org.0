Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31CCEE3BFF
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2019 21:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404032AbfJXT3Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Oct 2019 15:29:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55260 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725963AbfJXT3Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Oct 2019 15:29:16 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9OJQjHF074287
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Oct 2019 15:29:14 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vuj4c82qe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Oct 2019 15:29:14 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kselftest@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 24 Oct 2019 20:24:12 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 24 Oct 2019 20:24:09 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9OJO8Cw29819056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Oct 2019 19:24:08 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3C945204F;
        Thu, 24 Oct 2019 19:24:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.206.5])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5EC6D5204E;
        Thu, 24 Oct 2019 19:24:07 +0000 (GMT)
Subject: Re: [PATCH v1] selftest/trustedkeys: TPM 1.2 trusted keys test
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     David Howells <dhowells@redhat.com>, Petr Vorel <pvorel@suse.cz>,
        shuah <shuah@kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Date:   Thu, 24 Oct 2019 15:24:06 -0400
In-Reply-To: <1571944467-13097-1-git-send-email-zohar@linux.ibm.com>
References: <1571944467-13097-1-git-send-email-zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19102419-0020-0000-0000-0000037E1506
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102419-0021-0000-0000-000021D45DEA
Message-Id: <1571945046.11756.5.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-24_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910240182
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

Please note that I'm seeing "add_key: Timer expired" frequently.  This
is something new.  I have no idea if this is a new TPM or keys
regression.

Mimi


On Thu, 2019-10-24 at 15:14 -0400, Mimi Zohar wrote:
> Create, save and load trusted keys test
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> 
> Change log v1:
> - Replace the directions for using Trousers to take ownership of the TPM
> with directions for using the IBM TSS.
> - Differentiate between different types of errors.  Recent bug is causing
> "add_key: Timer expired".
> ---
>  tools/testing/selftests/tpm2/Makefile            |   2 +-
>  tools/testing/selftests/tpm2/test_trustedkeys.sh | 109 +++++++++++++++++++++++
>  2 files changed, 110 insertions(+), 1 deletion(-)
>  create mode 100755 tools/testing/selftests/tpm2/test_trustedkeys.sh
> 
> diff --git a/tools/testing/selftests/tpm2/Makefile b/tools/testing/selftests/tpm2/Makefile
> index 1a5db1eb8ed5..055bf62510b5 100644
> --- a/tools/testing/selftests/tpm2/Makefile
> +++ b/tools/testing/selftests/tpm2/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>  include ../lib.mk
>  
> -TEST_PROGS := test_smoke.sh test_space.sh
> +TEST_PROGS := test_smoke.sh test_space.sh test_trustedkey.sh
>  TEST_PROGS_EXTENDED := tpm2.py tpm2_tests.py
> diff --git a/tools/testing/selftests/tpm2/test_trustedkeys.sh b/tools/testing/selftests/tpm2/test_trustedkeys.sh
> new file mode 100755
> index 000000000000..dc7df7467670
> --- /dev/null
> +++ b/tools/testing/selftests/tpm2/test_trustedkeys.sh
> @@ -0,0 +1,109 @@
> +#!/bin/sh
> +
> +VERBOSE="${VERBOSE:-1}"
> +TRUSTEDKEY1="$(mktemp -u XXXX).blob"
> +TRUSTEDKEY2="$(mktemp -u XXXX).blob"
> +ERRMSG="$(mktemp -u XXXX)"
> +trap "echo PRETRAP" SIGINT SIGTERM SIGTSTP
> +trap "{ rm -f $TRUSTEDKEY1 $TRUSTEDKEY2 $ERRMSG; }" EXIT
> +
> +log_info()
> +{
> +        [ $VERBOSE -ne 0 ] && echo "[INFO] $1"
> +}
> +
> +# The ksefltest framework requirement returns 0 for PASS.
> +log_pass()
> +{
> +        [ $VERBOSE -ne 0 ] && echo "$1 [PASS]"
> +        exit 0
> +}
> +
> +# The ksefltest framework requirement returns 1 for FAIL.
> +log_fail()
> +{
> +        [ $VERBOSE -ne 0 ] && echo "$1 [FAIL]"
> +        exit 1
> +}
> +
> +# The ksefltest framework requirement returns 4 for SKIP.
> +log_skip()
> +{
> +        [ $VERBOSE -ne 0 ] && echo "$1"
> +        exit 4
> +}
> +
> +is_tpm1()
> +{
> +	local pcrs_path="/sys/class/tpm/tpm0/device/pcrs"
> +	if [ ! -f "$pcrs_path" ]; then
> +		pcrs_path="/sys/class/misc/tpm0/device/pcrs"
> +	fi
> +
> +	if [ ! -f "$pcrs_path" ]; then
> +		log_skip "TPM 1.2 chip not found"
> +	fi
> +}
> +
> +takeownership_info()
> +{
> +	log_info "creating trusted key failed, probably requires taking TPM ownership:"
> +	which tss1oiap > /dev/null 2>&1 || \
> +		log_info "    tss1oiap not found, install IBM TSS"
> +
> +	log_info "    export TPM_DEVICE=/dev/tpm0"
> +	log_info "    export TPM_ENCRYPT_SESSIONS=0"
> +
> +	log_info "    OIAP=\$(tss1oiap | cut -d' ' -f 2)"
> +	log_info "    tss1takeownership -se0 \$OIAP 0"
> +	log_fail "creating trusted key"
> +}
> +
> +test_trustedkey()
> +{
> +	#local keyid="$(keyctl add trusted kmk-test "new 64" @u)" &> $ERRMSG
> +	local keyid="$(keyctl add trusted kmk-test "new 64" @u 2> $ERRMSG)"
> +
> +	grep -E -q "add_key: Operation not permitted" $ERRMSG
> +	if [ $? -eq 0 ]; then
> +		takeownership_info
> +	fi
> +
> +	grep -E -q "add_key: " $ERRMSG
> +	if [ $? -eq 0 ]; then
> +		log_info "`cat ${ERRMSG}`"
> +		log_fail "creating trusted key"
> +	fi
> +	
> +	if [ -z "$keyid" ]; then
> +		log_fail "creating trusted key failed"
> +	fi
> +	log_info "creating trusted key succeeded"
> +
> +	# save newly created trusted key and remove from keyring
> +	keyctl pipe "$keyid" > "$TRUSTEDKEY1"
> +	keyctl unlink "$keyid" &> /dev/null
> +
> +	keyid=$(keyctl add trusted kmk-test "load `cat $TRUSTEDKEY1`" @u)
> +	if [ $? -eq 0 ]; then
> +		log_info "loading trusted key succeeded"
> +	else
> +		log_fail "loading trusted key failed"
> +	fi
> +
> +	# save loaded trusted key and remove from keyring again
> +	keyctl pipe "$keyid" > "$TRUSTEDKEY2"
> +	keyctl unlink "$keyid" &> /dev/null
> +
> +	# compare trusted keys
> +	diff "$TRUSTEDKEY1" "$TRUSTEDKEY2" &> /dev/null
> +	ret=$?
> +	if [ $ret -eq 0 ]; then
> +		log_pass "trusted key test succeeded"
> +	else
> +		log_fail "trusted key test failed"
> +	fi
> +}
> +
> +is_tpm1
> +test_trustedkey

